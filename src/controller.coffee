# src/controller.coffee

class Controller extends require './singleton'

  @controllers: {}

  constructor: ->
    @name = @constructor.name.split('Controller')[0].toLowerCase()
    Controller.controllers[@name] = @constructor

  #@resource: (name) ->
  #  @controllers[name] = @

module.exports = Controller
