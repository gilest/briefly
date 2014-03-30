class FormDecorator

  decorate: (article) ->
    $('#article_title').val article.title
    $('.field_image').css 'background', "url('#{article.remote_image_url}')"
    $('#article_remote_image_url').val article.remote_image_url
    $('#article_summary').val article.summary

  reset: ->
    $('#article_title').val ''
    $('.field_image').removeAttr 'style'
    $('#article_remote_image_url').val ''
    $('#article_summary').val ''

ready = ->

  if $('#article_form').length

    window.form_decorator = new FormDecorator

    $('#article_form').on 'blur','#article_link', ->
      url = $('#article_link').val()
      if /http:\/\/|https:\/\//.test(url) # don't bother unless it kind of looks like a url
        $.ajax
          type: 'POST'
          dataType: 'json'
          url: "/scrape"
          data: { 'url': url }
          success: (article) ->
            window.last_scrape = article
            form_decorator.decorate article
          error: (jqXHR, textStatus, errorThrown) ->
            console.log textStatus
            form_decorator.reset()
      else
        form_decorator.reset()

# turbolinks $(document).ready fix
$(document).ready(ready)
$(document).on('page:load', ready)