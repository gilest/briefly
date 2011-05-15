class RenameOrderToPositionInArticles < ActiveRecord::Migration
  def self.up
    rename_column :articles, :order, :position 
  end

  def self.down
    rename_column :articles, :position, :order 
  end
end
