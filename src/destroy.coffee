module.exports = (Model) ->
  (req, res) ->
    Model.findById req.params._id, (err, model) ->
      if err
        console.log err.message
        res.send 404, err.message
      model.set req.params
      model.remove (err) ->
        if err
          console.log err.message
          res.send 400, err.message
        res.send model
