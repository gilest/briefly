module ApplicationHelper

  def admin?
    !session[:admin].nil?
  end

  def shortened_article_url(article)
    "http://#{Briefly::Application.config.shortener_domain}#{':3000' if Rails.env.development?}/#{article.shortener_string}"
  end

end
