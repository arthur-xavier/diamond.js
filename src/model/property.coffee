# src/model/property.coffee

class Property extends require '../class'

  constructor: (@model, @name, options = {}) ->
    @type = if typeof options == "function" then options else options.type or String
    @default = options.default
    @value = options.value
    @save = options.save
    @model.validation @name, options.validation if options.validation?

  set: (model, value) ->
    if @value?
      value = if typeof @value == "function" then @value.call model else @value

    if !value?
      if @default?
        #console.log "Setting property #{@name} from default #{@default}"
        value = if typeof @default == "function" then @default.call model else @default
      else
        #console.log "Setting property #{@name} from type #{@type}"
        value = if @type.prototype then new @type else @type()
    else if value.properties?
      return value
    else if value.constructor != @type
      #value = if @type.prototype? then new @type value else @type value
      value = @type value

    value


module.exports = Property
