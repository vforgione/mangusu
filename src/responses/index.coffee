module.exports = {

  # 20x
  ok: (res, body) ->
    res.send 200, body

  created: (res, body) ->
    res.send 201, body

  no_content: (res, body) ->
    res.send 204, body

  reset: (res, body) ->
    res.send 205, body

  # 40x
  bad_request: (res, body) ->
    console.log body
    res.send 400, body

  unauthorized: (res, body) ->
    console.log body
    res.send 401, body

  forbidden: (res, body) ->
    console.log body
    res.send 403, body

  not_found: (res, body) ->
    console.log body
    res.send 404, body

  not_acceptable: (res, body) ->
    console.log body
    res.send 406, body

  conflict: (res, body) ->
    console.log body
    res.send 409, body

  # 50x
  internal_error: (res, body) ->
    console.log body
    res.send 500, body

}
