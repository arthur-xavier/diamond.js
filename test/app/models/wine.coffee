# test/app/models/wine.coffee

Model = require "#{root}/model"
Region = require "#{dependencies}/models/region"

class Wine extends Model
  #
  @collection: 'wines'
  
  #
  @property 'name', String, save: (name) -> name.toUpperCase()
  @property 'description', String
  @property 'year', Number, default: -> new Date().getFullYear()
  #@property 'region', Region.type 'location'
  
  @hasOne 'region', Region, key: 'location'
  
  @validation 'name', pattern: /^[A-Z\s]+$/
  @validation 'region', presence: true
  @validation 'year', (year) ->
    year <= new Date().getFullYear()

  toString: ->
    "'#{@get 'name'} #{@get 'year'}' from #{@get 'region.location'}"

module.exports = Wine
