module.exports = (Model) ->
  (req, res) ->
    Model.find (err, models) ->
      if err
        console.log err
        res.send 400, err.message
      res.send models
