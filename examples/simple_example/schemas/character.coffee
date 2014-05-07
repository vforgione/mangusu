mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

Organization = require './organization'


CharacterSchema = new Schema {
  name: { type: String, required: true }
  aliases: [ String ]
  organizations: [ { type: ObjectId, ref: Organization } ]
}


module.exports = mongoose.model 'Character', CharacterSchema
