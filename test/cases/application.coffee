# test/cases/application.coffee

global.app = require "#{dependencies}/app"
should = require 'should'

describe 'Application', ->

  require "#{cases}/router"
  require "#{cases}/controller"
  require "#{cases}/model"