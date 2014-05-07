mongoose = require 'mongoose'
Schema = mongoose.Schema


OrganizationSchema = new Schema {
  name: { type: String, required: true }
  description: { type: String, required: true }
  active: { type: Boolean, required: true }
}


module.exports = mongoose.model 'Organization', OrganizationSchema
