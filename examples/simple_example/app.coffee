express = require 'express'
http = require 'http'
mongoose = require 'mongoose'

app = express()

mongoose.connect 'mongodb://localhost:27017/mangusu-simple-example'

app.set 'port', 3000
app.use express.logger()
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use app.router
app.use express.errorHandler()

organization_resource = require './resources/organization_resource'
character_resource = require './resources/character_resource'

organization_resource.make_routes app
character_resource.make_routes app

http.createServer(app).listen app.get('port'), ->
  console.log "express server listening on port #{app.get('port')}"
