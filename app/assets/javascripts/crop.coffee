class Cropper

  constructor: ->
    @_original_image = new Image()
    @_original_image.src = $('#cropbox').attr('src')

  update_crop: (coords) =>
    ratio = @_original_image.width / 960
    $("#crop_x").val Math.round(coords.x * ratio)
    $("#crop_y").val Math.round(coords.y * ratio)
    $("#crop_w").val Math.round(coords.w * ratio)
    $("#crop_h").val Math.round(coords.h * ratio)

ready = ->

  if $('#cropbox').length

    window.cropper = new Cropper

    $("#cropbox").Jcrop
      onChange: cropper.update_crop
      onSelect: cropper.update_crop
      setSelect: [0, 0, 960, 350 ]
      aspectRatio: 2.742857142857143

# turbolinks $(document).ready fix
$(document).ready(ready)
$(document).on('page:load', ready)