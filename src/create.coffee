module.exports = (Model) ->
  (req, res) ->
    model = new Model req.body
    model.save (err) ->
      if err
        console.log err.message
        res.send 400, err.message
      res.send model
