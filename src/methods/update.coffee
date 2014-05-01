respond = require '../responses'

module.exports = (Model) ->
  (req, res) ->
    Model.findById req.params._id, (err, model) ->
      if err
        respond.not_found res, err.message
      model.set req.params
      model.save (err) ->
        if err
          respond.not_acceptable res, err.message
        respond.reset res, model
