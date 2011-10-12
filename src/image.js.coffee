@module "img", ->
  class @Image
    constructor: (@src, @output = null) ->
      @buffer = img.utils.getImageData(@src)
      @width = @src.width
      @height = @src.height
      @update()

    setSaturation: (amount) =>
      @saturation += amount
      img.actions.saturation(@buffer, amount)
      @update()

    update: =>
      @draw(@output)

    draw: (output) =>
      output = @src unless output?
      img.utils.drawImage(@buffer, @src)
