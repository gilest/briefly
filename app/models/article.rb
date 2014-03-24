# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  link       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  text       :text
#  position   :integer
#  image      :string(255)
#

class Article < ActiveRecord::Base
  validates_presence_of :title, :image, :link, :position

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  # has_attached_file :image, :styles => { :banner => "661x240#" }, :processors => [:cropper]
  mount_uploader :image, ImageUploader

  after_update :crop_image

  def crop_image
    image.recreate_versions! if crop_x.present?
  end

end
