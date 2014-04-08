require 'spec_helper'

describe Api::V1::ArticlesController do

  it 'response succesfully' do
    get :index, format: :json
    expect(response).to be_successful
  end

end
