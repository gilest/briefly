class ArticlePublisher

  def initialize(articles)
    @articles = articles
  end

  def publish
    @articles.each do |article|

    end
  end

  def tweeter
    @tweeter ||= Tweeter.new
  end

  def poster
    @poster ||= Poster.new
  end

end