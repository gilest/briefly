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

  mount_uploader :image, ImageUploader

  after_update :crop_image

  scope :by_position, -> { order('position asc, id desc') }

  def crop_image
    image.recreate_versions! if crop_x.present?
  end

  def current_position
    hash = Hash[Article.by_position.map.with_index.to_a]
    hash[self] + 1
  end

  def self.next_position
    articles = Article.by_position
    articles.empty? ? 1 : articles.first.position - 1
  end

end
