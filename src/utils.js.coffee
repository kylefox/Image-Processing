@module "img.utils", ->

  # Returns a [canvas, context] to read the source images's data.
  @createCanvas = (image) ->
    canvas = document.createElement('canvas')
    canvas.width = image.width
    canvas.height = image.height
    context = canvas.getContext('2d')
    [canvas, context]

  # Returns an Image's ImageData.
  @getImageData = (image) ->
    context = @createCanvas(image)[1]
    context.drawImage(image, 0, 0)
    context.getImageData(0, 0, image.width, image.height)
    
  @drawImage = (buffer, destination) ->
    if destination instanceof HTMLCanvasElement
      canvas = destination
    else
      canvas = document.createElement('canvas')
    canvas.width = buffer.width
    canvas.height = buffer.height
    ctx = canvas.getContext('2d')
    ctx.putImageData(buffer, 0, 0)
    if destination instanceof HTMLImageElement
      destination.src = canvas.toDataURL()

  @eachPixel = (imageData, callback) ->
    pixels = imageData.data
    bufferSize = pixels.length
    for n in [0...bufferSize] by 4
      callback(pixels, n)