respond = require '../responses'

module.exports = (Model) ->
  (req, res) ->
    Model.findById req.params._id, (err, model) ->
      if err
        respond.not_found res, err.message
      model.remove (err) ->
        if err
          respond.not_acceptable res, err.message
        respond.no_content res, model
