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
    constructor: (@src) ->
      @buffer = img.utils.getImageData(@src)
      @width = @src.width
      @height = @src.height
      @_saturation = 0
      
      Object.defineProperty @, 'saturation',
        get: () => @_saturation,
        set: @setSaturation

    setSaturation: (amount) =>
      img.actions.desaturate(@buffer, amount)
    
    draw: (canvas) =>
      canvas.width = @width
      canvas.height = @height
      ctx = canvas.getContext('2d')
      ctx.putImageData(@buffer, 0, 0)