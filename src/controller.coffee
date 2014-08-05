# src/controller.coffee

class Controller extends require './singleton'

  @controllers: {}

  constructor: ->
    @name = @constructor.name.split('Controller')[0].toLowerCase()
    Controller.controllers[@name] = @constructor

  send: (args...) ->
    @response.send args...

  json: (args...) ->
    @response.json args...

  error: (type, args...) ->
    @response.writeHead type, "Content-type": "text/plain"
    @response.end args...

  #@resource: (name) ->
  #  @controllers[name] = @

module.exports = Controller
