# test/test.coffee

path = require 'path'

global.root = path.join "#{__dirname}/../src/"
global.cases = path.join "#{__dirname}/cases"
global.dependencies = path.join "#{__dirname}/app"


require "#{cases}/application"
