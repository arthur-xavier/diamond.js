# src/application.coffee

express = require 'express'

class Diamond
  constructor: (callback) ->
    @server = express()
    @port = process.env.PORT || 3000

    callback.call @ if callback?

  listen: (callback) ->
    @server.listen @port
    callback.call @ if callback?

  @Router: require './router'
  @Model: require './model'
  @Controller: require './controller'

module.exports = Diamond
