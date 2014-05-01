respond = require '../responses'

module.exports = (Model) ->
  (req, res) ->
    model = new Model req.body
    model.save (err) ->
      if err
        respond.not_acceptable res, err.message
      respond.created res, model
