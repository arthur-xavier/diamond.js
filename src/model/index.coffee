# src/model/index.coffee

Property = require './property'
Validation = require './validation'

class Model extends require '../class'

  @properties: {}
  @property: (name, options) ->
    @properties[name] = new Property @, name, options

  @validations: {}
  @validation: (name, options) ->
    throw "No property named #{name}" if !@properties[name]?
    @validations[name] = new Validation @, name, options

  properties: {}
  constructor: (options = {}) ->
    for k, p of @constructor.properties
      @properties[k] = p.set @, options[k]

  get: (name) ->
    @properties[name]
  set: (name, value) ->
    @properties[name] = @getField(name).set @, value

  has: (name) ->
    @properties[name]?

  getField: (name) ->
    @constructor.properties[name]
  hasField: (name) ->
    @constructor.properties[name]?

  validate: (options = {}) ->
    errors = {}
    for k, v of @constructor.validations
      error = v.validate @get(k), options[k]
      errors[k] = error if error
    errors

module.exports = Model
