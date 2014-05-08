respond = require '../responses'

module.exports = (Model, emitter) ->
  (req, res) ->
    # use mongoose's method to destroy a single doc by id
    Model.findByIdAndRemove req.params._id, (err) ->
      # catch any errors
      if err then respond.not_found res, err.message

      # respond successful destruction
      else
        emitter.emit 'destroyed', req.params._id
        respond.no_content res
