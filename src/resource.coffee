class Resource

  constructor: (@model, resource_name) ->
    @many_path   = "/#{resource_name}"
    @single_path = "/#{resource_name}/:_id"

  find_one: ->
    require('./methods/find_one')(@model)

  find: ->
    require('./methods/find')(@model)

  create: ->
    require('./methods/create')(@model)

  update: ->
    require('./methods/update')(@model)

  destroy: ->
    require('./methods/destroy')(@model)

  make_routes: (app) ->
    app.get     @single_path, @find_one()
    app.get     @many_path,   @find()
    app.post    @many_path,   @create()
    app.put     @single_path, @update()
    app.delete  @single_path, @destroy()


module.exports = Resource
