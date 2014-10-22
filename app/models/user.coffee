mongoose = require 'mongoose'
bcrypt = require 'bcrypt'

UserSchema = mongoose.Schema {
	local: {
		username: String,
		password: String,
	},
	facebook: {
		id: String,
		token: String,
		email: String,
		name: String,
	}
}

UserSchema.methods.generateHash = (password) ->
	bcrypt.hashSync(password, bcrypt.genSaltSync 8, null)

UserSchema.methods.validPassword = (password) ->
	bcrypt.compareSync(password, this.local.password)

module.exports = mongoose.model('User', UserSchema)