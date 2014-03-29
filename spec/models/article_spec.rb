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

require 'spec_helper'

describe Article do
  
  before :each do
    @article = create :article
  end

  describe "validations" do

    it 'is valid' do
      expect(@article).to be_valid
    end

    it "should be invalid if missing any of the required attributes" do
      required_attributes = [:title, :image, :link]
      required_attributes.each do |attr|
        @article.send(:"#{attr}=", nil)
        expect(@article).to be_invalid
      end
    end

  end

  describe "moving" do

    before :each do
      Article.delete_all
      @article3 = create :article
      @article2 = create :article
      @article1 = create :article
    end

    it { expect(@article1.reload.first?).to be(true) }
    it { expect(@article3.reload.last?).to be(true) }

    it "moving the bottom article up to the top" do
      @article3.reload.move_higher
      @article3.reload.move_higher
      expect(@article3.reload.first?).to be true
      expect(@article2.reload.last?).to be true
    end

  end

end
