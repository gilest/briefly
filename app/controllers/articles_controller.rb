class ArticlesController < ApplicationController

  before_action :authenticate!, except: [:index]
  before_action :load_articles, except: [:scrape, :delete]

  def index
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_crop_path(@article), notice: "Article created"
    else
      render action: :index, anchor: 'error_explanation'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def crop
    @article = Article.find(params[:article_id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      if params[:article][:image].blank?
        redirect_to articles_path, notice: "Article updated"
      else
       redirect_to article_crop_path(@article)
      end
    else
      render action: :edit, anchor: 'error_explanation'
    end
  end

  def scrape
    scraper = Scrapers::Router.scraper_for(params[:url])
    puts "Routed to #{scraper}"
    respond_to do |format|
      format.json { render json: scraper.new(params[:url]).scrape }
    end
  end

  def up
    @article = Article.find(params[:article_id])
    @article.move_higher
    redirect_to articles_path(anchor: @article.position)
  end

  def down
    @article = Article.find(params[:article_id])
    @article.move_lower
    redirect_to articles_path(anchor: @article.position)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, notice: "Article destroyed"
  end

  protected

  def load_articles
    @articles = Article.all
  end

  def article_params
    params.require(:article).permit(:title, :image, :summary, :link, :position, :crop_x, :crop_y, :crop_w, :crop_h, :updated_at, :image, :remote_image_url)
  end

end
