# test/app/app.coffee

Diamond = require "#{root}/application"
path = require 'path'

app = new Diamond ->
  @port = 3000

  new (require "#{dependencies}/controllers/testController")
  new (require "#{dependencies}/controllers/wineController")

  @router = new Diamond.Router @server, require "#{dependencies}/routes"
  
app.listen ->
  console.log "Server listening on port #{@port}"

module.exports = app
