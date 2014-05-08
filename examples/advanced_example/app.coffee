express = require 'express'
http = require 'http'
mongoose = require 'mongoose'

app = express()

mongoose.connect 'mongodb://localhost:27017/mangusu-advanced-example'

app.set 'port', 3000
app.use express.logger()
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use app.router
app.use express.errorHandler()

brand_resource = require './resources/brand_resource'
vendor_resource = require './resources/vendor_resource'
product_resource = require './resources/product_resource'

brand_resource.make_routes app
vendor_resource.make_routes app
product_resource.make_routes app

http.createServer(app).listen app.get('port'), ->
  console.log "express server listening on port #{app.get('port')}"
