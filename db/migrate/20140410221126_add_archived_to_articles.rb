class AddArchivedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :archived, :boolean, default: false
  end
end
