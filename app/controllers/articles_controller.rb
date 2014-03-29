class ArticlesController < ApplicationController

  before_action :authenticate!, except: [:index]
  before_action :load_articles, except: [:delete]
  
  def index
    @article = Article.new
    
  end
  
  def create
    @article = Article.new(article_params)
    if @article.save
      Article.reorder!
      redirect_to article_crop_path(@article), notice: "Article created"
    else
      render action: "index", anchor: 'error_explanation'
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
      render action: :edit
    end
  end
  
  def up
    @article = Article.find(params[:article_id])
    if @article.move!(:up)
      redirect_to articles_path(anchor: @article.position), notice: "Article moved up"
    else
      redirect_to articles_path(anchor: @article.position), notice: "Article already first"
    end
  end
  
  def down
    @article = Article.find(params[:article_id])
    if @article.move!(:down)
      redirect_to articles_path(anchor: @article.position), notice: "Article moved down"
    else
      redirect_to articles_path(anchor: @article.position), notice: "Article already last"
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    Article.reorder!
    redirect_to articles_path, notice: "Article destroyed"
  end
  
  protected

  def load_articles
    @articles = Article.by_position
  end

  def article_params
    params.require(:article).permit(:title, :image, :text, :link, :position, :crop_x, :crop_y, :crop_w, :crop_h, :updated_at, :image)
  end

end
