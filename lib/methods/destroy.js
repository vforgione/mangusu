// Generated by CoffeeScript 1.7.1
(function() {
  var respond;

  respond = require('../responses');

  module.exports = function(Model, emitter) {
    return function(req, res) {
      return Model.findByIdAndRemove(req.params._id, function(err) {
        if (err) {
          return respond.not_found(res, err.message);
        } else {
          emitter.emit('destroyed', req.params._id);
          return respond.no_content(res);
        }
      });
    };
  };

}).call(this);
