respond = require '../responses'

module.exports = (Model) ->
  (req, res) ->
    # use mongoose's method to destroy a single doc by id
    Model.findByIdAndRemove req.params._id, (err, model) ->
      # catch any errors
      if err then respond.not_found res, err.message
      # respond successful destruction
      else respond.no_content res, model
