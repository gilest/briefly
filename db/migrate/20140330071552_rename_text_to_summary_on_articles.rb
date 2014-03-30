class RenameTextToSummaryOnArticles < ActiveRecord::Migration
  def up
    add_column :articles, :summary, :text
    Article.all.each {|article| article.update_column :summary, article.text }
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
