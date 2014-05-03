###
determines if an object is an array
###
isArray = Array.isArray || ( value ) -> return {}.toString.call( value ) is '[object Array]'


module.exports = {

  ###
  creates a `resource_uri` property for the given model

  @param model: an instance of a `mongoose.model`
  @param path: the path supplied in the resource's `options`

  @returns: the updated `model` param
  ###
  self_uri: (model, path) ->
    model._doc.resource_uri = "#{path}/#{model._id}"

  ###
  converts `_id` strings of referenced models to resource paths

  @param model: an instance of a `mongoose.model`
  @param refs: the refs supplied in the resource's `options`

  @returns: the updated `model` param
  ###
  ref2resource: (model, refs) ->
    for key, resource of refs
      if isArray model[key]
        for i, val of model[key]
          if model._doc[key][i]? then model._doc[key][i] = "#{resource.many_path}/#{val}"
      else
        if model._doc[key]? then model._doc[key] = "#{resource.many_path}/#{model[key]}"

}
