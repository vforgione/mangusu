_ = require 'lodash'


###
creates a general resource object for mapping http methods to mongoose model methods

options:
  limit: Integer -- the maximum number of documents to be returned given a `find` call
  refs: Object -- a mapping of model keys to resources for given db refs in the schema

@property options: the options used in configuration
@property many_path: the routing path for retrieving multiple models
@property single_path: the routing path for retrieving a single model

@method find_one: finds a document for a given `_id`
@method find: finds multiple documents, optionally restricts to a query, sort, and pagination
@method create: creates a new document with a given a payload
@method update: updates a document matching an `_id` with a given payload
@method destroy: destroys a document with a given `_id`
@method make_routes: create a routing map
###
class Resource

  ###
  builds the `resource` object

  @param model: an instance of a `mongoose.model`
  @param resource_name: the routing path for the resource
  @param options : [optional] an object of options to be used in configuration
  ###
  constructor: (@model, resource_name, options) ->
    # defaults
    @options = { limit: 20, refs: null }

    # params
    @many_path   = "/#{resource_name}"
    @single_path = "/#{resource_name}/:_id"

    # overwrite defaults
    _.merge @options, options
    @options.path = @many_path

  ###
  returns a single document matching the `_id` request parameter
  ###
  find_one: ->
    require('./methods/find_one')(@model, @options)

  ###
  returns an array of documents, optionally restricted to a query string
  ###
  find: ->
    require('./methods/find')(@model, @options)

  ###
  returns a new document created with the request body
  ###
  create: ->
    require('./methods/create')(@model, @options)

  ###
  updates a new document matching the `_id` request parameter with the request body
  ###
  update: ->
    require('./methods/update')(@model, @options)

  ###
  destroys a single document matching the `_id` request parameter
  ###
  destroy: ->
    require('./methods/destroy')(@model)

  ###
  sets paths to method handlers for the application

  @param app: the express application in use
  ###
  make_routes: (app) ->
    app.get     @single_path, @find_one()
    app.get     @many_path,   @find()
    app.post    @many_path,   @create()
    app.put     @single_path, @update()
    app.delete  @single_path, @destroy()


module.exports = Resource
