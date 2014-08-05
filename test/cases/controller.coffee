# test/cases/controller.coffee

Controller = require "#{root}/controller"
WineController = require "#{dependencies}/controllers/wineController"
TestController = require "#{dependencies}/controllers/testController"

request = require 'request'

describe 'Controller', ->

  it 'should extend singleton', ->
    WineController.getInstance().should.be.ok

  it 'should keep track of resource controllers', (done) ->
    WineController.getInstance().test = done
    Controller.controllers.wine.getInstance().test()

  it 'should receive params', (done) ->
    TestController.getInstance().param = ->
      @params.test.should.equal "world"
      done()

    request 'http://localhost:3000/hello/param/world'

  it 'should send json', (done) ->
    TestController.getInstance().param = ->
      @json test: @params.test

    request 'http://localhost:3000/hello/param/world', (err, response, body) ->
      JSON.parse(body).should.eql test: "world"
      done()