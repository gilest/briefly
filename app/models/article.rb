# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  link       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  position   :integer
#  image      :string(255)
#  summary    :text
#

class Article < ActiveRecord::Base
  validates_presence_of :title, :image, :link

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  mount_uploader :image, ImageUploader

  after_update :crop_image
  after_create :move_to_top

  acts_as_list

  default_scope -> { order('position asc, id asc') }

  def crop_image
    image.recreate_versions! if crop_x.present?
  end

  def current_position
    hash = Hash[Article.all.map.with_index.to_a]
    hash[self] + 1
  end

  def as_json(options = {})
    {
      id: position,
      title: title,
      summary: summary,
      link: link,
      image: image.url
    }
  end

end
