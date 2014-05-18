class AddTweetedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :tweeted, :boolean, default: false
  end
end
