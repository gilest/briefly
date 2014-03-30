class RemoveTextFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :text, :text
  end
end
