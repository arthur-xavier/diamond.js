{spawn, exec} = require 'child_process'

task 'build', 'Builds diamond framework to js', ->
  exec 'coffee --compile --output lib/ src/', (err, stdout, stderr) ->
    throw err if err
    console.log stdout, stderr