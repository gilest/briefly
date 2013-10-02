include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :article do
    title "Sample Article"
    image { fixture_file_upload(Rails.root.join('spec/fixtures/lolcat.jpg'), 'image/jpg') }
    link "http://www.google.com"
    position 0
  end

end