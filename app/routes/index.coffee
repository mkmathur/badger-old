express = require 'express'
local = require './localauth'

module.exports = (app, passport) ->
	app.get('/', (req, res) ->
			res.sendfile('./public/index.html')
		)

	auth = express.Router()
	auth.route '/signup'
		.post local.signup passport
	auth.route '/login'
		.post local.login passport
	auth.route '/logout'
		.get local.logout
	app.use('/auth', auth)



