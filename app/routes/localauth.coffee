exports.signup = (passport) ->
	passport.authenticate('local-signup', {
			successRedirect: '/success',
			failureRedirect: '/failure',
			failureFlash: true
		})

exports.login = (passport) ->
	passport.authenticate('local-login', {
			successRedirect: '/success',
			failureRedirect: '/failure',
			failureFlash: true
		})

exports.logout = (req, res) ->
	req.logout()
	res.redirect('/')




		
