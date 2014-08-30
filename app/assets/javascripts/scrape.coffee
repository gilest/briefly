class FormDecorator

  decorate: (article) ->
    $('#article_title').val article.title
    $('.art_img').css 'background-image', "url('#{article.remote_image_url}')"
    $('#article_remote_image_url').val article.remote_image_url
    $('#article_summary').val article.summary

  reset: ->
    $('#article_title').val ''
    $('.art_img').removeAttr 'style'
    $('#article_remote_image_url').val ''
    $('#article_summary').val ''

  loading: ->
    $('#loader').show()

  done: ->
    $('#loader').hide()

ready = ->

  if $('.scrape_link').length

    window.form_decorator = new FormDecorator

    $('.scrape_link').on 'blur', (event) ->
      url = $('.scrape_link').val()
      console.log url
      if /http:\/\/|https:\/\//.test(url) # don't bother unless it kind of looks like a url
        form_decorator.loading()
        $.ajax
          type: 'POST'
          dataType: 'json'
          url: "/scrape"
          data: { 'url': url }
          success: (article) ->
            form_decorator.done()
            form_decorator.decorate article
          error: (jqXHR, textStatus, errorThrown) ->
            console.log textStatus
            form_decorator.done()
            form_decorator.reset()
      else
        form_decorator.reset()

# turbolinks $(document).ready fix
$(document).ready(ready)
$(document).on('page:load', ready)