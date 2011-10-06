@module "img.effects", ->
  
  class Desaturate
    constructor: ->
      @amount = .5
    
    # Takes a pixel tuple (r,g,b,a) and returns their adjusted values.
    applyToPixel: (r, g, b, a) ->
      v = r*0.3 + g*0.59 + b*0.11
      [
        r += Math.round( (v-r) * @amount),
        g += Math.round( (v-g) * @amount),
        b += Math.round( (v-b) * @amount),
        255
      ]
      # [v, v, v, 255]

    adjustPixel: (pixels, n) =>
      rgba = @applyToPixel(pixels[n], pixels[n+1], pixels[n+3])
      pixels[n] = rgba[0]
      pixels[n+1] = rgba[1]
      pixels[n+2] = rgba[2]
      pixels[n+3] = rgba[3] or 255
      
    apply: (imageData) =>
      img.utils.eachPixel imageData, (pixels, n) =>
        @adjustPixel(pixels, n)
      imageData      
    
  @desaturate = (imageData, amount) ->
    d = new Desaturate()
    d.apply(imageData)