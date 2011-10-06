@module "img.actions", ->
  
  class Action
    adjustPixel: (pixels, n) =>
      rgba = @applyToPixel(pixels[n], pixels[n+1], pixels[n+2])
      pixels[n] = rgba[0]
      pixels[n+1] = rgba[1]
      pixels[n+2] = rgba[2]
      pixels[n+3] = rgba[3] or 255
      
    apply: (imageData) =>
      img.utils.eachPixel imageData, (pixels, n) =>
        @adjustPixel(pixels, n)
      imageData
        
  class Greyscale extends Action

    applyToPixel: (r, g, b, a) ->
      v = r*0.3 + g*0.59 + b*0.11
      [v, v, v, 255]
      
  class Desaturate extends Action
    
    d: (val, avg) ->
      @amount = -0.4
      val -= Math.round((avg - val) * @amount)
    
    applyToPixel: (r, g, b, a) ->
      avg = (r+g+b)/3
      [@d(r, avg), @d(g, avg), @d(b, avg), 255]
    
  @greyscale = (imageData) ->
    d = new Greyscale()
    d.apply(imageData)
    
  @desaturate = (imageData, amount) ->
    d = new Desaturate()
    d.apply(imageData)