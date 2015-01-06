# test/app/app.coffee

Diamond = require "#{root}/application"
path = require 'path'

express = require 'express'

app = new Diamond ->
  #
  @port = 3000
  @server = express()

  new (require "#{dependencies}/controllers/testController")
  new (require "#{dependencies}/controllers/wineController")

  @router = new Diamond.Router @server, require "#{dependencies}/routes"

  @db = new (require "#{dependencies}/helpers/mongodb")
  require "#{dependencies}/db"

  @server.listen @port, ->
    console.log "Server listening on port #{@port}"

module.exports = app
