mongoose = require 'mongoose'
Schema = mongoose.Schema

GroupSchema = new Schema {
	name: String,
	members: [Number],
	tasks: [Number]
}

module.exports = mongoose.model('Group', GroupSchema)
