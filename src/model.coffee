# src/model.coffee

Property = require './model/property'
Validation = require './model/validation'

Diamond = require './application'

class Model extends require './class'

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
    @name = @constructor.name
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

  # storage methods
  @all: (callback) ->
    Diamond.getInstance().db.all @, callback

  @count: (callback) ->
    Diamond.getInstance().db.count @, callback

  @find: (options, callback) ->
    Diamond.getInstance().db.find @, options, callback

  @findById: (id, callback) ->
    Diamond.getInstance().db.findById @, id, callback

  save: (callback) ->
    Diamond.getInstance().db.save @, callback

  update: (options, callback) ->
    Diamond.getInstance().db.update @, options, @oroperties, callback

  @update: (options, set, callback) ->
    Diamond.getInstance().db.update @, options, set, callback

  remove: (callback) ->
    Diamond.getInstance().db.remove @, @properties, callback

  @remove: (options, callback) ->
    Diamond.getInstance().db.remove @, options, callback

module.exports = Model
