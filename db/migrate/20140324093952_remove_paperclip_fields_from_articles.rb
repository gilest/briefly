class RemovePaperclipFieldsFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :image_file_name, :string
    remove_column :articles, :image_content_type, :string
    remove_column :articles, :image_file_size, :integer
    remove_column :articles, :image_updated_at, :datetime
  end
end
