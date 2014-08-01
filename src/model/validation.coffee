# src/model/validation.coffee

class Validation

  constructor: (@model, @name, options = {}) ->
    @pattern = options.pattern
    if @pattern and @model.properties[@name].type != String
      throw "Pattern validation on property not of type String"
      @pattern = null
    @presence = options.presence
    @function = options.function
    @function = options if typeof options == "function"

  validate: (value, options) ->
    isEmpty = (obj) ->
      return true if obj == null || obj == undefined
      return false if obj.length && obj.length > 0
      return true if obj.length == 0
      for key in obj
        return false if Object.prototype.hasOwnProperty.call(obj, key)
      return true;

    valid = true
    valid &&= @pattern.test(value) if @pattern
    if @presence
      valid &&= value && !isEmpty(value)
    valid &&= @function(value, options) if @function
    !valid

module.exports = Validation
