# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  # if Rails.env.production?
  #   storage :fog
  # else
    storage :file
  # end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  version :banner do
    process :crop
    process resize_to_fill: [960, 350, 'North']
  end

  def crop
    if model.respond_to?(:crop_x) && model.crop_x.present?
      manipulate! do |img|
        img.crop("#{model.crop_w}x#{model.crop_h}+#{model.crop_x}+#{model.crop_y}")
        img = yield(img) if block_given?
        img
      end
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
