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
    Diamond.getInstance().db.save @, callback

  update: (options, callback) ->
    Diamond.getInstance().db.update @, options, @oroperties, callback

  @update: (options, set, callback) ->
    Diamond.getInstance().db.update @, options, set, callback

  remove: (callback) ->
    Diamond.getInstance().db.remove @, @properties, callback

  @remove: (options, callback) ->
    Diamond.getInstance().db.remove @, options, callback

module.exports = Storage
