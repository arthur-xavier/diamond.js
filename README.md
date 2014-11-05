# diamond.js

> MVC web framework for node.js applications

## Installation
    $ npm install diamond.js

## Application

    # app/app.coffee

    Diamond = require 'diamond.js'
    express = require 'express'

    app = new Diamond ->
      @port = process.env.PORT or 3000

      @server.use express.static('../public')

      @server.use bodyParser.urlencoded extended: true
      @server.use bodyParser.json()

      # require controllers
      require './controllers/wineController'

      # setup router
      @router = new Diamond.Router @server, require './routes'

      # setup db
      @db = new (require './helpers/mongodb')
      require './db'

      @listen ->
        console.log "Server listening on port #{@port}"


## Routing

    # app/routes.coffee

    module.exports = ->
      @resource 'wine'
      @resource 'test'

      @get '/', 'test#test'

      @route '/hello', ->
        @route '/param', ->
          @get '/:test', 'test#param'

        @get '/:id/test', 'test#test'

## Model

### Example
#### Region
    # app/models/region.coffee

    class Region extends Diamond.Model
      
      @collection: 'regions'
      
      @property 'name', type: String
      @property 'country', type: String

      # computed property
      @property 'location', type: String, value: -> "#{@get 'name'}, #{@get 'country'}"
      
      @validation 'name', pattern: /^[A-Za-z\s]+$/
      @validation 'country', presence: true

      toString: ->
        @get 'location'

    module.exports = Region

#### Wine

    # app/models/wine.coffee

    class Wine extends Diamond.Model
      
      @collection: 'wines'
      
      
      @property 'name', type: String, save: (name) -> name.toUpperCase()
      @property 'description', type: String
      @property 'year', type: Number, default: -> new Date().getFullYear()
      @property 'region', type: String, save: (region) ->
        (region.get? 'location') or region
      
      @validation 'name', pattern: /^[A-Z\s]+$/
      @validation 'region', presence: true
      @validation 'year', (year) ->
        year <= new Date().getFullYear()

      toString: ->
        "'#{@get 'name'} #{@get 'year'}' from #{@get 'region.location'}"

    module.exports = Wine


## Controllers

### Example
    # app/controllers/wineController.coffee

    class WineController extends Diamond.Controller

      index: ->
        Wine.all (err, wines) =>
          @error err
          @send wines

      show: ->
        Wine.findById @params.id, (err, wine) =>
          @error err
          @send wine

      create: ->
        wine = new Wine @body
        wine.validate()
        wine.save (err) =>
          @error err
          @send @body

      update: ->
        wine = new Wine @body
        wine.set 'id', @params.id
        wine.validate()
        wine.save (err) =>
          @error err
          @send @body

      destroy: ->
        Wine.remove id: @params.id, (error) =>
          @error error
          @send @body

    module.exports = WineController

## Storage

diamond.js provides no default storage methods, but it provides a storage interface that can - and must - be extended. Below is an example of a storage interface for mongodb:

    # app/helpers/mongodb.coffee

    mongojs = require 'mongojs'

    class MongoDB

      constructor: (callback) ->
        @db = mongojs 'mongodb://localhost:27017/database'

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


## Directory structure

    -- app
        |-- controllers
        |-- helpers
        |-- models
        | app.coffee
        | db.coffee
        | routes.cofee
    -- public
    -- test
     package.json

## License

The MIT License (MIT)

Copyright (c) 2014 Arthur Xavier &lt;xavier@dcc.ufmg.br&gt;

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
