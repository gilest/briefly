class EnsureShortenerStrings < ActiveRecord::Migration
  def up
    Article.all.each(&:ensure_shortener_string)
  end
end
