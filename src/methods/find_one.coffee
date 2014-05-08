respond = require '../responses'
ref2resource = require('./dry').ref2resource


module.exports = (Model, options) ->
  (req, res) ->
    Model.findById req.params._id, (err, model) ->
      # something went wrong
      if err
        respond.internal_error res, err.message

      # 404
      else if model == null
        respond.not_found res, "#{Model.modelName} with id #{req.params._id} not found"

      # got a match
      else
        # if refs option, update refs to resource uris
        if options.refs? then model._doc = ref2resource model._doc, options.refs

        # return model
        respond.ok res, model
