# == Schema Information
#
# Table name: articles
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  link             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  position         :integer
#  image            :string(255)
#  summary          :text
#  archived         :boolean          default(FALSE)
#  shortener_string :string(255)
#  visits           :integer
#

class Article < ActiveRecord::Base

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  validates_presence_of :title, :image, :link

  mount_uploader :image, ImageUploader

  after_update :crop_image
  after_create :move_to_top

  include HasShortenedUrl
  acts_as_list

  default_scope -> { where(archived: false).order('position asc, id asc') }

  def crop_image
    image.recreate_versions! if crop_x.present?
  end

  def current_position
    hash = Hash[Article.all.map.with_index.to_a]
    hash[self] + 1
  end

  def as_tweet
    "#{title.upcase} #{shortened_url}"
  end

  def publish!
    tweet!
  end

  def tweet!
    unless tweeted? or archived?
      Tweeter.new.client.update as_tweet
      update_column :tweeted, true
    end
  end

  def tweeted
    tweeted? ? 'Tweeted' : 'Not tweeted'
  end

  def as_json(options = {})
    {
      id: position,
      title: title,
      summary: summary,
      url: shortened_url,
      destination: link,
      image: image.url,
      image_banner: image.banner.url
    }
  end

  def record_visit!
    update_column :visits, visits + 1
  end

  def archive!
    remove_from_list
    update_column :archived, true
  end

end
