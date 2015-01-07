# src/model/property.coffee

isPrimitive = (t) -> t == Boolean or t == Number or t == String 

class Property extends require '../class'

  constructor: (@model, @name, type, options) ->
    options = type or {} if !options
    @type = if typeof type == "function" then type else type.type or String
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
        value = if @type.prototype and !isPrimitive(@type) then new @type else @type()
    else if value.properties?
      return value
    else if value.constructor != @type
      #value = if @type.prototype? then new @type value else @type value
      #value = if @type.prototype and !isPrimitive(@type) then new @type value else @type value
      value = @type value

    value


module.exports = Property
