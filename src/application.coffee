# src/application.coffee

class Diamond extends require './singleton'

  constructor: (callback) ->
    super
    Diamond.Model = require './model'
    Diamond.Router = require './router'
    Diamond.Controller = require './controller'
    callback.call @ if callback?

module.exports = Diamond
