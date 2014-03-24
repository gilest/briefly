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
    @article = FactoryGirl.create :article
  end

  describe "validations" do

    it 'is valid' do
      expect(@article).to be_valid
    end

  end

end
