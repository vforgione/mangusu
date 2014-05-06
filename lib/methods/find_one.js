// Generated by CoffeeScript 1.7.1
(function() {
  var ref2resource, respond;

  respond = require('../responses');

  ref2resource = require('./dry').ref2resource;

  module.exports = function(Model, options) {
    return function(req, res) {
      return Model.findById(req.params._id, function(err, model) {
        if (err) {
          return respond.internal_error(res, err.message);
        } else if (model === null) {
          return respond.not_found(res, "" + Model.modelName + " with id " + req.params._id + " not found");
        } else {
          if (options.refs != null) {
            ref2resource(model, options.refs);
          }
          return respond.ok(res, model);
        }
      });
    };
  };

}).call(this);