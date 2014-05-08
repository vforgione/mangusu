mongoose = require 'mongoose'
Schema = mongoose.Schema


BuyerSchema = new Schema {
  name: { type: String, required: true }
}


module.exports = mongoose.model 'Buyer', BuyerSchema
