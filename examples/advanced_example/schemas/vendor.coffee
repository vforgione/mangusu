mongoose = require 'mongoose'
Schema = mongoose.Schema


VendorSchema = new Schema {
  name: { type: String, required: true }
}


module.exports = mongoose.model 'Vendor', VendorSchema
