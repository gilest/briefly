class Article < ActiveRecord::Base
  validates_presence_of :title, :image, :link, :position
  has_attached_file :image, :styles => { :banner => "661x240#", :large => "661x" }, :processors => [:cropper]
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_image, :if => :cropping?
  
  def cropping?
     !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
   end

   def avatar_geometry(style = :original)
     @geometry ||= {}
     @geometry[style] ||= Paperclip::Geometry.from_file(image.path(style))
   end

   private

   def reprocess_image
     image.reprocess!
   end
end
