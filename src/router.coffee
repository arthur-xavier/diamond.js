# src/router.coffee

Controller = require './controller'

class Router

  constructor: (@server, callback) ->
    callback.call @ if callback?

  resource: (name, param = "id") ->
    @get "#{@prefix}/#{name}", "#{name}#index"
    @get "#{@prefix}/#{name}/:#{param}", "#{name}#show"
    @post "#{@prefix}/#{name}", "#{name}#create"
    @put "#{@prefix}/#{name}/:#{param}", "#{name}#update"
    @delete "#{@prefix}/#{name}/:#{param}", "#{name}#destroy"

  prefix: ''
  route: (prefix, callback) ->
    [@prefix, prefix] = [@prefix + prefix, @prefix]
    callback.call @ if callback?
    [@prefix, prefix] = [prefix, @prefix]

  #
  get: (route, action) ->
    @server.get "#{@prefix}#{route}", Router.route(@action action)
  post: (route, action) ->
    @server.post "#{@prefix}#{route}", Router.route(@action action)
  put: (route, action) ->
    @server.put "#{@prefix}#{route}", Router.route(@action action)
  delete: (route, action) ->
    @server.delete "#{@prefix}#{route}", Router.route(@action action)

  # 
  action: (action) ->
    [controller, action] = action.split('#')
    #controller =  controller.charAt(0).toUpperCase() + controller.slice(1) + "Controller"]
    {controller: Controller.controllers[controller].getInstance(), action: action}

  @route: (options) ->
    {controller, action} = options
    (req, res) ->
      controller.request = req or {}
      controller.response = res or {}
      controller.body = controller.request.body or {}
      controller.params = controller.request.params or {}
      controller[action].call controller, req, res

module.exports = Router
