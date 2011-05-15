class PublicController < ApplicationController
  def index
    @articles = Article.order("`position` asc, `id` desc")
  end
end