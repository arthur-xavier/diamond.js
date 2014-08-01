# src/controller.coffee

class Controller extends require './singleton'

  @controllers: {}

  @resource: (name) ->
    @controllers[name] = @

module.exports = Controller
