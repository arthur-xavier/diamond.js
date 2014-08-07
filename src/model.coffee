# src/model.coffee

Property = require './model/property'
Validation = require './model/validation'

class Model extends require './class'

  @extends require './model/storage'

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
    @collection = @constructor.collection
    throw "Undefined collection for model #{@constructor.name}" if !@collection?
    @hasError = false
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
    @hasError = false
    @errors = new Object
    for k, v of @constructor.validations
      error = v.validate @get(k), options[k]
      @hasError = true if error
      @errors[k] = error if error
    @errors = if @hasError then @errors else null
    @errors


module.exports = Model
