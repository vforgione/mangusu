Resource = require '../../../lib'
# in your code it would be `Resource = require 'mangusu'`

Organization = require '../schemas/organization'


module.exports = new Resource Organization, 'organizations'
