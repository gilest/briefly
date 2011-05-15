class AddTextToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :text, :text
  end

  def self.down
    remove_column :articles, :text
  end
end
