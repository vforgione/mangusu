respond = require '../responses'

module.exports = (Model) ->
  (req, res) ->
    Model.findById req.params._id, (err, model) ->
      if err
        respond.not_found res, err.message
      respond.ok res, model
