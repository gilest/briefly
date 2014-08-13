window.nav = {}
nav.current_article = 1
nav.enabled = true

nav.up = ->
  if nav.enabled
    nav.current_article--
    nav.current_article = 1 if nav.current_article < 1
    nav.scroll()
  return

nav.down = ->
  if nav.enabled
    number_of_articles = $(".article").length
    nav.current_article++
    nav.current_article = number_of_articles if nav.current_article > number_of_articles
    nav.scroll()
  return

nav.scroll = ->
  # ought to place the current article in around about the middle of the screen
  article_offset = $("##{nav.current_article}").offset().top
  article_height = $(".article").first().height()
  extra_padding = ($(window).height() - article_height) / 2
  scroll_offset = article_offset - extra_padding
  $(window).scrollTop(scroll_offset)
  $("##{nav.current_article}").focus()

ready = ->

  if $('.article').length

    # css selectors for all user input fields
    field_selectors = ['.user_field', '.password_field', '#article_title', '#article_summary', '#article_link', '#article_remote_image_url']

    $.each field_selectors, (index, selector) ->

      # disable keyboard navigation while fields have focus

      $(selector).focus ->
        nav.enabled = false

      $(selector).blur ->
        nav.enabled = true

    $(document).keyup (event) ->

      # (n)ext and (p)revious
      # (f)orwards and (b)ackwards for emacs users
      # (j) and (k) for vim users

      switch event.which
        when 74, 78, 70 then nav.down() # j, n, f
        when 75, 80, 66 then nav.up()   # k, p, b

# turbolinks $(document).ready fix
$(document).ready(ready)
$(document).on('page:load', ready)