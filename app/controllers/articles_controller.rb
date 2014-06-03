class ArticlesController < ApplicationController

  before_action :authenticate!, except: [:index, :show]
  before_action :set_article, except: [:index, :create, :publish, :scrape, :show]
  before_action :load_articles, except: [:scrape, :delete, :show]

  def index
    @article = Article.new
  end

  # special method used by url shortener brfly.com
  def show
    @article = Article.unscoped.find_by(shortener_string: params[:shortener_string])
    not_found if @article.nil?
    @article.record_visit!
    redirect_to @article.link
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to crop_article_path(@article), notice: "Article created"
    else
      render action: :index, anchor: 'error_explanation'
    end
  end

  def edit
  end

  def crop
  end

  def update
    if @article.update_attributes(article_params)
      if params[:article][:image].blank?
        redirect_to articles_path, notice: "Article updated"
      else
       redirect_to crop_article_path(@article)
      end
    else
      render action: :edit, anchor: 'error_explanation'
    end
  end

  def publish
    @articles.each(&:publish!)
    redirect_to articles_path, notice: 'Articles published'
  end

  def scrape
    scraper = Scrapers::Router.scraper_for(params[:url])
    puts "Routed to #{scraper}"
    respond_to do |format|
      format.json { render json: scraper.new(params[:url]).scrape }
    end
  end

  def up
    @article.move_higher
    redirect_to articles_path(anchor: @article.position)
  end

  def down
    @article.move_lower
    redirect_to articles_path(anchor: @article.position)
  end

  def archive
    @article.archive!
    redirect_to articles_path, notice: "Article archived"
  end

  protected

  def set_article
    @article = Article.find(params[:id])
  end

  def load_articles
    @articles = Article.all
  end

  def article_params
    params.require(:article).permit(:title, :image, :summary, :link, :position, :crop_x, :crop_y, :crop_w, :crop_h, :updated_at, :image, :remote_image_url)
  end

end
