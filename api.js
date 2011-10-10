// Demo API ...
var img = new img.Image(source)

img.adjust({
  
  saturation: 0.33,
  hue: img.GREEN,
  lightness: .25,
  
  // RGBA
  screen: [140, 85, 12, .5],
  
  // Function to calculate curve.
  curves: function() { },
  
});