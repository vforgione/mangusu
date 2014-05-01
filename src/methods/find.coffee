respond = require '../responses'

module.exports = (Model) ->
  (req, res) ->
    Model.find (err, models) ->
      if err
        respond.bad_request res, err.message
      respond.ok res, models
