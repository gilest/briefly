class Api::V1::ArticlesController < Api::V1::ApiController

  def index
    @articles = Article.all
    respond_with @articles
  end

end
