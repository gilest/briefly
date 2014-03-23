# == Schema Information
#
# Table name: articles
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  link               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  text               :text
#  position           :integer
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Article < ActiveRecord::Base
  validates_presence_of :title, :image, :link, :position
  has_attached_file :image, :styles => { :banner => "661x240#" }, :processors => [:cropper]
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(image.path(style))
  end

end
