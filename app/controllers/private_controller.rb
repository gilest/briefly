class PrivateController < ApplicationController
  
  before_filter :authenticate
  
  def index
    @article = Article.new
    @articles = Article.order("`position` asc")
  end
  
  def create
    @article = Article.new(params[:article])
    if @article.save
      flash[:notice] = "Successfully created user."  
      redirect_to crop_article_path(@article), :notice => "Article updated"
    end
  end

  def edit
    @article = Article.find(params[:id])
  end
  
  def crop
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      if params[:article][:image].blank?
        redirect_to article_path, :notice => "Article updated"
      else
       render :action => "crop"
     end
    end
  end
  
  def up
    @article = Article.find(params[:id])
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
      
      @above.update_attributes(:position => below)
      @article.update_attributes(:position => above)
      
      redirect_to article_path(:anchor => @article.position), :notice => "Article moved up"
    else
      redirect_to article_path(:anchor => @article.position), :notice => "Article already first"
    end
  end
  
  def down
    @article = Article.find(params[:id])
    @articles = Article.order("position asc").all
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
      
      @below.update_attributes(:position => above)
      @article.update_attributes(:position => below)
      
      redirect_to article_path(:anchor => @article.position), :notice => "Article moved down"
    else
      redirect_to article_path(:anchor => @article.position), :notice => "Article already last"
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to article_path, :notice => "Article destroyed"
  end
  
  protected

  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == "George" && password == "babelfish"
    end
  end

end
