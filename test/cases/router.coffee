# test/cases/router.coffee

Router = require "#{root}/router"
TestController = require "#{dependencies}/controllers/testController"

request = require 'request'

describe 'Router', ->

  it 'should call controller actions from routes', (done) ->
    TestController.getInstance().test = done

    @router = new Router

    {controller, action} = @router.action 'test#test'
    controller[action]()

  it 'should generate routes to controllers', (done) ->
    TestController.getInstance().test = done
    Router.route(@router.action 'test#test')()

  it 'should route requests to controller actions', (done) ->
    TestController.getInstance().test = -> done()
    request 'http://localhost:3000/'

  it 'should define resource routes', (done) ->
    TestController.getInstance().update = -> done()
    request.put 'http://localhost:3000/test/1'
    
  #it 'should define sub-routes', (done) ->
  #  TestController.getInstance().test = -> done()
  #  request 'http://localhost:3000/hello/world/test'

  it 'should define sub-routes in resources', (done) ->
    TestController.getInstance().test = -> done()
    request 'http://localhost:3000/test/sub/test'
