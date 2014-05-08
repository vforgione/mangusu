Resource = require '../../../lib'
# in your code it would be: `Resource = require 'mangusu'`

Brand = require '../schemas/brand'


module.exports = new Resource Brand, 'brands'
