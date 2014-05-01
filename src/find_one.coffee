module.exports = (Model) ->
  (req, res) ->
    Model.findById req.params._id, (err, model) ->
      if err
        console.log err.message
        res.send 404, err.message
      res.send model
