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