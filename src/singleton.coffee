# src/singleton.coffee

class Singleton extends require './class'
  @_instance: null
  @getInstance: ->
    @_instance or= new @
    @_instance

  constructor: ->
    @constructor._instance or= @

module.exports = Singleton

