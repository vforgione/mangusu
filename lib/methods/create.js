// Generated by CoffeeScript 1.7.1
(function() {
  var ref2resource, respond, self_uri;

  respond = require('../responses');

  ref2resource = require('./dry').ref2resource;

  self_uri = require('./dry').self_uri;

  module.exports = function(Model, emitter, options) {
    return function(req, res) {
      var model;
      model = new Model(req.body);
      return model.save(function(err) {
        if (err) {
          return respond.not_acceptable(res, err.message);
        } else {
          if (options.refs != null) {
            model._doc = ref2resource(model._doc, options.refs);
          }
          self_uri(model, options.path);
          emitter.emit('created', JSON.stringify(model._doc));
          return respond.ok(res, model);
        }
      });
    };
  };

}).call(this);
