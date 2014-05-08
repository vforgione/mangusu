Resource = require '../../../lib'
# in your code it would be: `Resource = require 'mangusu'`

Product = require '../schemas/product'

BrandResource = require './brand_resource'
BuyerResource = require './buyer_resource'
VendorResource = require './vendor_resource'


module.exports = new Resource Product, 'products', { refs: {
  brand: BrandResource, buyers: BuyerResource, 'vendors.vendor': VendorResource } }
