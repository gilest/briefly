window.nav = {}
nav.currentFocusInt = 0

nav.moveUp = ->
  nav.currentFocusInt--
  nav.currentFocusInt = 1 if nav.currentFocusInt < 1
  $("#" + nav.currentFocusInt).focus()
  return

nav.moveDown = ->
  numberArticlesInt = $(".article").length
  nav.currentFocusInt++
  nav.currentFocusInt = numberArticlesInt if nav.currentFocusInt > numberArticlesInt
  $("#" + nav.currentFocusInt).focus()
  return


ready = ->

  if $('.article').length

    $(document).keyup (event) ->

      # (n)ext and (p)revious
      # (f)orwards and (b)ackwards for emacs users
      # (j) and (k) for vim users

      switch event.which
        when 74, 78, 70 then nav.moveDown() # j n, f
        when 75, 80, 66 then nav.moveUp()   # k p, b

# turbolinks $(document).ready fix
$(document).ready(ready)
$(document).on('page:load', ready)