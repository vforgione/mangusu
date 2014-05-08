mongoose = require 'mongoose'
Schema = mongoose.Schema


BrandSchema = new Schema {
  name: { type: String, required: true }
}


module.exports = mongoose.model 'Brand', BrandSchema
