# src/model/index.coffee

Property = require './model/property'
Validation = require './model/validation'

class Model extends require './class'

  # storage models
  @MongoDB: require './model/storage/mongodb'

  # model properties
  @properties: {}
  @property: (name, options) ->
    @properties[name] = new Property @, name, options

  # model validations
  @validations: {}
  @validation: (name, options) ->
    throw "No property named #{name}" if !@properties[name]?
    @validations[name] = new Validation @, name, options

  #
  constructor: (options = {}) ->
    @properties = new Object
    @name = @constructor.name.toLowerCase()
    for k, p of @constructor.properties
      @properties[k] = p.set @, options[k]

  #
  get: (name) ->
    @properties[name]
  set: (name, value) ->
    @properties[name] = @getField(name).set @, value
  has: (name) ->
    @properties[name]?

  #
  getProperty: (name) ->
    @constructor.properties[name]
  hasProperty: (name) ->
    @constructor.properties[name]?

  #
  validate: (options = {}) ->
    errors = {}
    for k, v of @constructor.validations
      error = v.validate @get(k), options[k]
      errors[k] = error if error
    errors

module.exports = Model
