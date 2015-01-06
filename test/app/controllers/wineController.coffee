# test/app/controllers/wineController.coffee

Controller = require "#{root}/controller"
Wine = require "#{dependencies}/models/wine"

class WineController extends Controller

  index: ->
    Wine.all (err, wines) =>
      @error err
      @send wines

  show: ->
    Wine.findById @params.id, (err, wine) =>
      @error err
      @send wine

  create: ->
    wine = new Wine @body
    wine.validate()
    wine.save (err) =>
      @error err
      @send @body

  update: ->
    wine = new Wine @body
    wine.set 'id', @params.id
    wine.validate()
    wine.save (err) =>
      @error err
      @send @body

  destroy: ->
    Wine.remove id: @params.id, (error) =>
      @error error
      @send @body

module.exports = WineController
