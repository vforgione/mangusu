respond = require '../responses'
ref2resource = require('./dry').ref2resource
self_uri = require('./dry').self_uri


module.exports = (Model, emitter, options) ->
  (req, res) ->
    # create a new model with the payload
    model = new Model req.body

    # save it
    model.save (err) ->
      # catch validation issues
      if err then respond.not_acceptable res, err.message

      # good to go
      else
        # if refs option, update refs to resource uris
        if options.refs? then ref2resource model, options.refs
        # create a self uri
        self_uri model, options.path

        # emit event
        emitter.emit 'created', JSON.stringify model._doc

        # return model
        respond.ok res, model
