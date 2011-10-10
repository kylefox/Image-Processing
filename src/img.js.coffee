# = require_self
# = require utils
# = require actions
window.img = {};

Array::remove = (e) -> @[t..t] = [] if (t = @.indexOf(e)) > -1

# From the CoffeeScript Wiki
# https://github.com/jashkenas/coffee-script/wiki/Easy-modules-with-CoffeeScript
@module = (names, fn) ->
  names = names.split '.' if typeof names is 'string'
  space = @[names.shift()] ||= {}
  space.module ||= @module
  if names.length
    space.module names, fn
  else
    fn.call space
    
@module "img", ->
  class @Image
    constructor: (@src, @output = null) ->
      ###
      TODO: Clone original @buffer.
      As adjustments are made, the buffer is modified. This means subsequent
      adjustments are applied to the modified buffer, resulting in unexpected effects.

      For example:
        image.saturation = 0.5
        image.saturation = 0
        
      In the above code you'd expect the `= 0` to reset to the original saturation, but instead
      it has no effect on the output because it's altering the current buffer's saturation by 0.
      ###
      @buffer = img.utils.getImageData(@src)
      @width = @src.width
      @height = @src.height
      @_saturation = 0
      
      Object.defineProperty @, 'saturation',
        get: () => @_saturation,
        set: @setSaturation

      @update()

    setSaturation: (amount) =>
      @_saturation = amount
      img.actions.saturation(@buffer, @_saturation)
      @update()
    
    # Removes any adjustments.
    reset: =>
      
    
    update: =>
      @draw(@output)

    draw: (output) =>
      output = @src unless output?
      img.utils.drawImage(@buffer, @src)
