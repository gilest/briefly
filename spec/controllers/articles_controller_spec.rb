require 'spec_helper'

describe ArticlesController do

  describe 'GET show with a valid url' do

    before :each do
      @article = create :article
      get :show, shortener_string: @article.shortener_string
    end

    it "should redirect to the article link" do
      expect(response).to redirect_to(@article.link)
    end

    it "should have incremented the article visits" do
      expect(@article.reload.visits).to eq(1)
    end

  end

  describe 'GET show with an invalid url' do

    it "should redirect to the article link" do
      expect { get :show, shortener_string: 'anj28fmcian' }.to raise_error(ActionController::RoutingError, /Not Found/)
    end

  end

end