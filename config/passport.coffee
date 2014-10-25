LocalStrategy = require('passport-local').Strategy 
User = require './../app/models/user'

module.exports = (passport) ->
	passport.serializeUser (user, done) ->
		done(null, user.id)

	passport.deserializeUser (id, done) ->
		User.findById(id, (err, user) -> done(err, user))

	# LOCAL SIGNUP
	# we are using named strategies since we have one for login and one for signup

	passport.use('local-signup', new LocalStrategy({ passReqToCallback: true }, (req, username, password, done) ->
			process.nextTick () ->
				User.findOne({ 'local.username' : username }, (err, user) ->
						return done err if err
						if user 
							return done(null, false, req.flash('signupMessage', 'That username is already taken.'))
						else
							newUser = new User()
							newUser.local.username = username
							newUser.local.password = newUser.generateHash password 
							newUser.save (err) ->
								throw err if err 
								return done(null, newUser)
					)
		))

	# LOCAL LOGIN
	passport.use('local-login', new LocalStrategy({ passReqToCallback: true }, (req, username, password, done) ->
			User.findOne({ 'local.username' : username }, (err, user) ->
					return done err if err
					if !user
						return done(null, false, req.flash('loginMessage', 'No user found.'))
					if !user.validPassword(password)
						return done(null, false, req.flash('loginMessage', 'Oops! Wrong password.'))
					done(null, user)
				)
		))



