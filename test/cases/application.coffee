# test/cases/application.coffee

global.app = require "#{dependencies}/app"

describe 'Application', ->

  require "#{cases}/router"
  require "#{cases}/controller"
  require "#{cases}/model"