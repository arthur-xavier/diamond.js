# test/app/models/wine.coffee

Model = require "#{root}/model"

class Wine extends Model
  #
  @collection: 'wines'
  
  #
  @property 'name', type: String, save: (name) -> name.toUpperCase()
  @property 'description', type: String
  @property 'year', type: Number, default: -> new Date().getFullYear()
  @property 'region', type: String, save: (region) ->
    (region.get? 'location') or region
  
  @validation 'name', pattern: /^[A-Z\s]+$/
  @validation 'region', presence: true
  @validation 'year', (year) ->
    year <= new Date().getFullYear()

  toString: ->
    "'#{@get 'name'} #{@get 'year'}' from #{@get 'region.location'}"

module.exports = Wine
