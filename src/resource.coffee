class Resource

  constructor: (@model, path) ->
    @many_path   = "/#{path}"
    @single_path = "/#{path}/:_id"

  find_one: ->
    require('./find_one')(@model)

  find: ->
    require('./find')(@model)

  create: ->
    require('./create')(@model)

  update: ->
    require('./update')(@model)

  destroy: ->
    require('./destroy')(@model)

  make_routes: (app) ->
    app.get     @single_path, @find_one()
    app.get     @many_path,   @find()
    app.post    @many_path,   @create()
    app.put     @single_path, @update()
    app.delete  @single_path, @destroy()


module.exports = Resource
