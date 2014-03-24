class ArticlesController < ApplicationController
  
  before_filter :authenticate!, except: [:index]
  
  def index
    @article = Article.new
    @articles = Article.by_position
  end
  
  def create
    @articles = Article.by_position
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
    @articles = Article.order("position desc").all
    unless @article.position == @articles.last.position
      above_is_next = 0
      for article in @articles
        if above_is_next == 1
          @above = article
          above_is_next = 0
        end
        if article.position == @article.position
          above_is_next = 1
        end
      end
      
      above = @above.position
      below = @article.position
      
      @above.update_attributes(position: below)
      @article.update_attributes(position: above)
      
      Article.reorder!
      
      redirect_to articles_path(anchor: @article.position), notice: "Article moved up"
    else
      redirect_to articles_path(anchor: @article.position), notice: "Article already first"
    end
  end
  
  def down
    @article = Article.find(params[:article_id])
    @articles = Article.by_position.all
    unless @article.position == @articles.last.position
      below_is_next = 0
      for article in @articles
        if below_is_next == 1
          @below = article
          below_is_next = 0
        end
        if article.position == @article.position
          below_is_next = 1
        end
      end
      
      below = @below.position
      above = @article.position
      
      @below.update_attributes(position: above)
      @article.update_attributes(position: below)
      
      
      Article.reorder!
      
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

  def article_params
    params.require(:article).permit(:title, :image, :text, :link, :position, :crop_x, :crop_y, :crop_w, :crop_h, :updated_at, :image)
  end

end