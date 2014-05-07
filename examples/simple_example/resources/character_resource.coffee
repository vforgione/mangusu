Resource = require '../../../lib'
# in your code it would be `Resource = require 'mangusu'`

Character = require '../schemas/character'

OrganizationResource = require './organization_resource'


module.exports = new Resource Character, 'characters', { refs: { organizations: OrganizationResource } }
