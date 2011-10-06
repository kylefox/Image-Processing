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

  @eachPixel = (imageData, callback) ->
    pixels = imageData.data
    bufferSize = pixels.length
    for n in [0...bufferSize] by 4
      callback(pixels, n)