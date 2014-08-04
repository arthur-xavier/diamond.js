# src/application.coffee

express = require 'express'

class Diamond extends require './singleton'
  
  constructor: (callback) ->
    super
    @server = express()
    @port = process.env.PORT || 3000

    Diamond.Model = require './model'
    Diamond.Router = require './router'
    Diamond.Controller = require './controller'

    callback.call @ if callback?

  listen: (callback) ->
    @server.listen @port
    callback.call @ if callback?

module.exports = Diamond
