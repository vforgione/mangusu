_ = require 'lodash'

respond = require '../responses'
ref2resource = require('./dry').ref2resource
self_uri = require('./dry').self_uri


module.exports = (Model, options) ->
  (req, res) ->
    # set query params
    limit = req.query.limit || options.limit
    skip = req.query.skip || undefined
    sort = req.query.sort || undefined

    # correctly parse limit and skip to integers
    try
      limit = parseInt limit
    catch
      return respond.bad_request res, "could not parse integer from provided `limit` #{limit}"
    if skip
      try
        skip = parseInt skip
      catch
        return respond.bad_request res, "could not parse integer from provided `skip` #{skip}"

    # make one query object
    query = _.merge req.query, req.params
    # clean
    where = _.transform query , (conditions, value, key) ->
      if key not in ['limit', 'skip', 'sort']
        conditions[key] = value

    # parse out values - super useful for doing mongodb projections in a query string:
    # i.e. /people?age={"$gt":18,"$lt":35}
    for key, value of where
      where[key] = JSON.parse value

    # execute the query
    Model.find(where).sort(sort).skip(skip).limit(limit).exec (err, models) ->
      if err then respond.bad_request res, err.message
      else
        # update the models
        for model in models
          # if refs option, update refs to resource uris
          if options.refs? then ref2resource model, options.refs
          # create a self uri
          self_uri model, options.path

        # build meta object
        output = {}
        output.meta = {}

        output.meta.page_size = limit
        count = 0
        if not skip? then skip = 0

        # get total count for query without limits
        Model.count where, (err, count) ->
          if err then respond.bad_request res, err.message
          else
            output.meta.count = count

            # next page
            if count > limit and count > skip + limit
              if skip? then new_skip = skip + limit
              else new_skip = limit
              next = "#{options.path}?"
              if sort
                next += "sort=#{sort}&"
              next += "skip=#{new_skip}&limit=#{limit}"
            else next = null
            output.meta.next = next

            # previous page
            if skip? and skip != 0
              if (skip - limit) < 0 then new_skip = 0
              else new_skip = skip - limit
              prev = "#{options.path}?"
              if sort
                prev += "sort=#{sort}&"
              prev += "skip=#{new_skip}&limit=#{limit}"
            else prev = null
            output.meta.previous = prev

            # add models
            output.objects = models

            # respond
            respond.ok res, output
