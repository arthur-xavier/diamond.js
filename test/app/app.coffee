# test/app/app.coffee

Diamond = require "#{root}/application"
path = require 'path'

require "#{dependencies}/controllers/testController"
require "#{dependencies}/controllers/wineController"

app = new Diamond ->
  @port = 3000
  @server.use require('less-middleware')(path.join __dirname, 'public')

  @router = new Diamond.Router @server, require "#{dependencies}/routes"
  
app.listen ->
  console.log "Server listening on port #{@port}"

module.exports = app
