respond = require '../responses'
ref2resource = require('./dry').ref2resource
self_uri = require('./dry').self_uri


module.exports = (Model, options) ->
  (req, res) ->
    # use mongoose's method to update by id
    Model.findByIdAndUpdate req.params._id, req.body, (err, model) ->
      # catch validation errors
      if err then respond.not_acceptable res, err.message

      # good to go
      else
        # if refs option, update refs to resource uris
        if options.refs? then ref2resource model, options.refs
        # create a self uri
        self_uri model, options.path

        # return model
        respond.ok res, model
