Resource = require '../../../lib'
# in your code it would be: `Resource = require 'mangusu'`

Vendor = require '../schemas/vendor'


module.exports = new Resource Vendor, 'vendors'
