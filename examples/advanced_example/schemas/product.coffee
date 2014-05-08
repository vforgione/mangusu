mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId 

Brand = require './brand'
Buyer = require './buyer'
Vendor = require './vendor'


ProductSchema = new Schema {
  sku: { type: Number, required: true }
  name: { type: String, required: true }
  brand: { type: ObjectId, ref: Brand, required: true }
  vendors: [ {
    vendor: { type: ObjectId, ref: Vendor, required: true }
    vendor_sku: Number
    _id: false } ]
  buyers: [ { type: ObjectId, ref: Buyer } ]
}


module.exports = mongoose.model 'Product', ProductSchema
