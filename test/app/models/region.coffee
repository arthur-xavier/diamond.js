# test/app/models/region.coffee

Model = require "#{root}/model"

class Region extends Model
  #
  @collection: 'regions'
  
  #
  @property 'name', type: String
  @property 'country', type: String

  # computed property
  @property 'location', type: String, value: -> "#{@get 'name'}, #{@get 'country'}"
  
  @validation 'name', pattern: /^[A-Za-z\s]+$/
  @validation 'country', presence: true

  toString: ->
    @get 'location'

module.exports = Region
