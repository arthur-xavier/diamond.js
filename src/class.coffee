# src/class.coffee

class Class
  @constructors: {}
  @include: (o) ->
    @[k] = v for k, v of o.ClassMethods
    @prototype[k] = v for k, v of o when k isnt 'ClassMethods' and k isnt 'name' and k isnt 'constructor'
    @constructors[o.name] = o.constructor if o.constructor and o.name

  @extends: (o, options) ->
    @[k] = v for k, v of o when k isnt 'prototype'
    @prototype[k] = v for k, v of o.prototype
    @include options if options

  constructor: (options) ->
    for k, c of @constructor.constructors
      c.call @, options
    @init() if @init

module.exports = Class
