# app/helpers/mongodb.coffee

mongojs = require 'mongojs'

class MongoDB

  constructor: (callback) ->
    @db = mongojs 'mongodb://localhost:27017/winedb'

  all: (collection, callback) ->
    @db.collection(collection.collection or collection).find callback

  count: (collection, callback) ->
    @db.collection(collection.collection or collection).count callback

  find: (collection, model, callback) ->
    @db.collection(collection.collection or collection).find model, callback

  findById: (collection, id, callback) ->
    @db.collection(collection.collection or collection).findOne {_id: mongojs.ObjectId id}, callback

  save: (collection, model, callback) ->
    @db.collection(collection).save model.properties or model, callback

  update: (collection, model, set, callback) ->
    @db.collection(collection).update model, {$set: set}, {multi: true}, callback

  remove: (collection, model, callback) ->
    @db.collection(collection.collection or collection).remove model, callback

module.exports = MongoDB
