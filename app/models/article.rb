class Article < ActiveRecord::Base
  validates_presence_of :title, :image, :link, :position
  has_attached_file :image, :styles => { :banner => "661x240#" }
end
