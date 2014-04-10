class AddVisitsAndShortenerStringToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :shortener_string, :string
    add_column :articles, :visits, :integer, default: 0
    add_index  :articles, :shortener_string
  end
end
