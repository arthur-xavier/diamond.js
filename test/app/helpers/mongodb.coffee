# app/helpers/mongodb.coffee

mongojs = require 'mongojs'

class MongoDB

  constructor: (callback) ->
    @db = mongojs 'mongodb://localhost:27017/winedb'

  all: (model, callback) ->
    @db.collection(model.collection).find callback

  count: (model, callback) ->
    @db.collection(model.collection).count callback

  find: (model, options, callback) ->
    @db.collection(model.collection).find options, callback

  findById: (model, id, callback) ->
    @db.collection(model.collection).findOne {_id: mongojs.ObjectId id}, callback

  save: (model, callback) ->
    @db.collection(model.collection).save model.properties, callback

  update: (model, options, set, callback) ->
    @db.collection(model.collection).update options, {$set: set}, {multi: true}, callback

  remove: (model, options, callback) ->
    @db.collection(model.collection).remove options, callback

module.exports = MongoDB
