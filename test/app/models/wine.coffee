# test/app/models/wine.coffee

Model = require "#{root}/model"

class Wine extends Model
  @property 'name', type: String
  @property 'description', type: String
  @property 'city', type: String
  @property 'country', type: String
  @property 'year', type: Number, default: -> new Date().getFullYear()

  # computed property
  @property 'location', type: String, value: -> "#{@get 'city'}, #{@get 'country'}"
  
  @validation 'name', pattern: /^[A-Za-z\s]+$/
  @validation 'country', presence: true
  @validation 'year', (year) ->
    year <= new Date().getFullYear()

  toString: ->
    "'#{@get 'name'} #{@get 'year'}' from #{@get 'location'}"

module.exports = Wine
