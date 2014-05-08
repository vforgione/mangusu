isArray = Array.isArray || ( value ) -> return {}.toString.call( value ) is '[object Array]'


r2r = (doc, refs) ->
  new_doc = JSON.parse(JSON.stringify doc)
  for key, resource of refs
    parts = key.split '.'
    if parts.length == 1
      new_doc[key] = "#{resource.many_path}/#{new_doc[key]}"
    else
      _key = parts[0]
      subdoc = new_doc[_key]
      new_key = parts.slice(1).join '.'
      new_refs = {}
      new_refs[new_key] = resource
      if isArray subdoc
        new_subdoc = []
        for el in subdoc
          val = r2r el, new_refs
          new_subdoc.push val
        new_doc[_key] = new_subdoc
      else
        new_doc[_key] = r2r subdoc, new_refs
  new_doc


module.exports = {

  self_uri: (model, path) ->
    model._doc.resource_uri = "#{path}/#{model._id}"

  ref2resource: r2r

}
