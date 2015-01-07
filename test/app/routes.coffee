# test/app/routes.coffee

module.exports = ->
  @resource 'wine'
  @resource 'test', ->
    @get '/sub/test', 'test#test'

  @get '/', 'test#test'

  @route '/hello', ->
    @route '/param', ->
      @get '/:test', 'test#param'

    @get '/:id/test', 'test#test'
