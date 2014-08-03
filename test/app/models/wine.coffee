# test/app/models/wine.coffee

Model = require "#{root}/model"

class Wine extends Model
  #
  @property 'name', type: String
  @property 'description', type: String
  @property 'country', type: String
  @property 'region', type: String
  @property 'year', type: Number, default: -> new Date().getFullYear()

  # computed property
  @property 'location', type: String, value: -> "#{@get 'region'}, #{@get 'country'}"
  
  @validation 'name', pattern: /^[A-Z\s]+$/
  @validation 'country', presence: true
  @validation 'year', (year) ->
    year <= new Date().getFullYear()

  toString: ->
    "'#{@get 'name'} #{@get 'year'}' from #{@get 'location'}"

module.exports = Wine
