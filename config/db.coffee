mongoose = require 'mongoose'

dbURI = process.env.MONGOLAB_URI || process.env.MONGOHQ_URL || 'mongodb://localhost/badger'

mongoose.connect dbURI
db = mongoose.connection

db.on('error', (err) -> console.error('connection error: %s', err))
db.once('open', -> console.log('connected to db at ' + dbURI))
db.on('disconnected', -> console.log('disconnected from db'))
