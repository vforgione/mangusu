Resource = require '../../../lib'
# in your code it would be: `Resource = require 'mangusu'`

Product = require '../schemas/product'

BrandResource = require './brand_resource'
VendorResource = require './vendor_resource'


module.exports = new Resource Product, 'products', { refs: { brand: BrandResource, 'vendors.vendor': VendorResource } }
