Resource = require '../../../lib'
# in your code it would be: `Resource = require 'mangusu'`

Buyer = require '../schemas/buyer'


module.exports = new Resource Buyer, 'buyers'
