# src/model/storage.coffee

Diamond = require '../application'

class Storage
  @all: (callback) ->
    Diamond.getInstance().db.all @, callback

  @count: (callback) ->
    Diamond.getInstance().db.count @, callback

  @find: (options, callback) ->
    Diamond.getInstance().db.find @, options, callback
  @findById: (id, callback) ->
    Diamond.getInstance().db.findById @, id, callback

  find: (callback) ->
    @constructor.find @constructor, @properties, callback
  findById: (callback) ->
    @constructor.findById @constructor, @id, callback

  @save: (model, callback) ->
    properties = model.properties
    if !model.hasError
      for k, v of model.properties when @properties[k]
        properties[k] = @properties[k].save.call @, v if @properties[k].save
      Diamond.getInstance().db.save @collection, properties, callback
    else
      callback model.errors

  save: (callback) ->
    properties = @properties
    if !@hasError 
      for k, v of @properties when @constructor.properties[k]
        properties[k] = @constructor.properties[k].save.call @, v if @constructor.properties[k].save
      Diamond.getInstance().db.save @collection, properties, callback
    else
      callback @errors

  update: (options, callback) ->
    properties = @properties
    if !@hasError
      for k, v of @properties when @constructor.properties[k]
        properties[k] = @constructor.properties[k].save.call @, v if @constructor.properties[k].save
      Diamond.getInstance().db.update @collection, options, properties, callback
    else
      callback @errors

  @update: (options, set, callback) ->
    Diamond.getInstance().db.update @collection, options, set, callback

  remove: (callback) ->
    Diamond.getInstance().db.remove @, @properties, callback

  @remove: (options, callback) ->
    Diamond.getInstance().db.remove @, options, callback

module.exports = Storage
