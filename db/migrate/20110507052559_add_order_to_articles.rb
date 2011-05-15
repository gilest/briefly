class AddOrderToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :order, :integer
  end

  def self.down
    remove_column :articles, :order
  end
end
