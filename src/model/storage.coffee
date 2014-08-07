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

  save: (callback) ->
    if !@hasError 
      for k, v of @properties when @constructor.properties[k]
        @constructor.properties[k].save v if @constructor.properties[k].save
      Diamond.getInstance().db.save @, callback
    else
      callback @errors

  update: (options, callback) ->
    if !@hasError
      for k, v of @properties when @constructor.properties[k]
        @constructor.properties[k].save v if @constructor.properties[k].save
      Diamond.getInstance().db.update @, options, @properties, callback
    else
      callback @errors

  @update: (options, set, callback) ->
    Diamond.getInstance().db.update @, options, set, callback

  remove: (callback) ->
    Diamond.getInstance().db.remove @, @properties, callback

  @remove: (options, callback) ->
    Diamond.getInstance().db.remove @, options, callback

module.exports = Storage
