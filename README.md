This is a scratch pad for a JavaScript library (written in CoffeeScript) for processing images. Adjustments are applied to `<img>` tags by replacing the image with a `<canvas>`.
  
Example:
========

Assuming your markup contains `<img id="image" src="boat.png">` you could do something like this:

    image = new img.Image( document.getElementById('image') );
    image.setSaturation(.5);
    image.draw()
    
Creating actions
================

Create a custom action by subclassing `img.actions.Action` and overriding either the `adjustPixel` or `apply` methods.

Adjusting a single pixel
------------------------

Overwrite `adjustPixel` if your algorithm simply applies a calculation to a single pixel (for example, greyscale):

    class Greyscale extends img.actions.Action
    
      # Parameters: the red, green, blue, and alpha values of the source pixel.
      # Returns: the new (adjusted) values for the pixel.
      applyToPixel: (r, g, b, a) ->
        v = r*0.3 + g*0.59 + b*0.11
        [v, v, v, 255]
        

Complex actions
---------------

If your action cannot be applied per-pixel (for example, the new value for a pixel depends on the values of its neighbouring pixels) you can override the `apply` method to process the image data however you want:

    class Mosaic extends img.actions.Action
    
      # Parameter: the ImageData of the source image (array of pixel values).
      # Returns: the new (adjusted) array of pixel values.
      apply: (imageData) =>
        # Your crazy processing goes here...
        return imageData

    
The code is mostly experimental, but you might find some useful utilities hidden inside. Feel free to fork & add new stuff, or to repurpose however you see fit.