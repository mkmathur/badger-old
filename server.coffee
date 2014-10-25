# BASE SETUP

express = require 'express'
app = express()
port = process.env.PORT || 8080

# DEPENDENCIES
path = require 'path'
mongoose = require 'mongoose'
passport = require 'passport'
flash = require 'connect-flash'
morgan = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
session = require 'express-session'

# CONFIGURE

require './config/db'
require('./config/passport')(passport)
# middleware = require('./config/middleware')

# set up express application
app.use morgan 'dev'
app.use cookieParser()
app.use bodyParser.json()
app.use bodyParser.urlencoded()

# required for passport
app.use session { secret: 'mysecret' }
app.use passport.initialize()
app.use passport.session()
app.use flash()

# ROUTES

require('./app/routes/index')(app, passport)

# START THE SERVER
app.listen(port)
console.log('Magic happens on port ' + port)
