@module "img.color", ->

  ###
  Converts an RGB color value to HSL.
  Assumes r, g, and b are contained in the set [0, 255].
  Returns [h,s,l] - h is 0-359º, s and l are in the set [0, 1].
  A modified version of this algorithm:
  http://stackoverflow.com/questions/2348597/why-doesnt-this-javascript-rgb-to-hsl-code-work/2348659#2348659
  ###
  @rgbToHsl = (r, g, b) ->
    min = Math.min(r, g, b)
    max = Math.max(r, g, b)
    delta = max - min
    l = Math.round(max / 255 * 100)
    if max != 0
      s = Math.round(delta / max * 100)
    else
      return [0, 0, 0]

    if r == max # between yellow & magenta
      h = ( g - b ) / delta
    else if g == max # between cyan & yellow
      h = 2 + ( b - r ) / delta
    else # between magenta & cyan
      h = 4 + ( r - g ) / delta
      
    h = 0 if delta == 0
    
    h = Math.floor(h * 60) # degrees
    h += 360 if h < 0
    return [h, s, l];


  ###
  Converts an HSL color value to RGB.
  Returns [r, g, b] where each value is between 0-255.

  @param h: Hue, in degrees (0-359)
  @param s: Saturation (0-100)
  @param l: Lightness (0-100)
  
  Modified version of this algorithm:
  http://matthaynes.net/blog/2008/08/07/javascript-colour-functions/
  ###
  @hslToRgb = (h, s, l) ->
    s = s / 100
    l = l / 100
    hi = Math.floor((h/60) % 6)
    f = (h / 60) - hi
    p = l * (1 - s)
    q = l * (1 - f * s)
    t = l * (1 - (1 - f) * s)
    
    rgb = switch hi
      when 0 then [l,t,p]
      when 1 then [q,l,p]
      when 2 then [p,l,t]
      when 3 then [p,q,l]
      when 4 then [t,p,l]
      when 5 then [l,p,q]
  
    r = Math.min(255, Math.round(rgb[0]*256))
    g = Math.min(255, Math.round(rgb[1]*256))
    b = Math.min(255, Math.round(rgb[2]*256))
    return [r,g,b]
