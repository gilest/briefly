require 'carrierwave/test/matchers'

describe ImageUploader do
  include CarrierWave::Test::Matchers

  before :each do
    image_path = Rails.root.join('spec', 'fixtures', 'lolcat.jpg')
    ImageUploader.enable_processing = true
    @article = create :article
    @image_uploader = ImageUploader.new(@article, :image)
    @image_uploader.store!(File.open(image_path))
  end

  after :each do
    ImageUploader.enable_processing = false
    @image_uploader.remove!
  end

  it "should create a banner image at 661x240" do
    expect(@image_uploader.banner).to have_dimensions(960, 350)
  end

  it "should make the image readable only to the owner and not executable" do
    expect(@image_uploader).to have_permissions(0644)
  end

end
