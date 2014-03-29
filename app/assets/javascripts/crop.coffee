class Cropper

  update_crop: (coords) =>
    rx = 661 / coords.w
    ry = 240 / coords.h
    ratio = @original_width() / 661
    $("#crop_x").val Math.round(coords.x * ratio)
    $("#crop_y").val Math.round(coords.y * ratio)
    $("#crop_w").val Math.round(coords.w * ratio)
    $("#crop_h").val Math.round(coords.h * ratio)

  original_width: =>
    image = new Image()
    image.src = $('#cropbox').attr('src')
    return image.width

ready = ->

  if $('#cropbox').length

    window.cropper = new Cropper

    $("#cropbox").Jcrop
      onChange: cropper.update_crop
      onSelect: cropper.update_crop
      setSelect: [0, 0, 661, 240 ]
      aspectRatio: 2.754166666666667

# turbolinks $(document).ready fix
$(document).ready(ready)
$(document).on('page:load', ready)