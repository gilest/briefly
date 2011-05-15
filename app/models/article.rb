class Article < ActiveRecord::Base
  validates_presence_of :title, :image, :link, :position
  has_attached_file :image
end
