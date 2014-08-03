# src/model/property.coffee

class Property extends require '../class'

  constructor: (@model, @name, options = {}) ->
    @type = options.type or String
    @default = options.default
    @value = options.value

  set: (model, value) ->
    if @value?
      value = if typeof @value == "function" then @value.call model else @value

    if !value
      if @default?
        #console.log "Setting property #{@name} from default #{@default}"
        value = if typeof @default == "function" then @default.call(@model) else @default
      else
        #console.log "Setting property #{@name} from type #{@type}"
        value = @type()
    else
      #console.log "Setting property #{@name} from value #{value}"
      value = @type value
    value


module.exports = Property
