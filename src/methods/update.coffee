diff = require('deep-diff').diff

respond = require '../responses'
ref2resource = require('./dry').ref2resource
self_uri = require('./dry').self_uri


module.exports = (Model, emitter, options) ->
  (req, res) ->
    Model.findById req.params._id, (err, original_model) ->
      # catch 404
      if err
        return respond.not_found res, "#{Model.modelName} with id #{req.params._id} not found"

      # use mongoose's method to update by id
      Model.findByIdAndUpdate req.params._id, req.body, (err, new_model) ->
        # catch validation errors
        if err then respond.not_acceptable res, err.message

        # good to go
        else
          # if refs option, update refs to resource uris
          if options.refs? then new_model._doc = ref2resource new_model._doc, options.refs

          # emit event
          difference = diff(original_model._doc, new_model._doc)
          emitter.emit 'updated', JSON.stringify difference

          # return model
          respond.ok res, new_model
