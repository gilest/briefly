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
