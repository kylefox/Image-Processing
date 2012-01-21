This is a scratch pad for a JavaScript library (written in CoffeeScript) for processing images. Adjustments are applied to `<img>` tags by replacing the image with a `<canvas>`.
  
Example:

    image = new img.Image( document.getElementById('image') );
    image.setSaturation(.5);
    image.draw()
    
The code is mostly experimental, but you might find some useful utilities hidden inside. Feel free to fork & add new stuff, or to repurpose however you see fit.