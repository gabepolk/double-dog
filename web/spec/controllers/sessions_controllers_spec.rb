require 'spec_helper'

RSpec.describe MoviesController, :type => :controller do

  describe "GET 'show_matilda'" do
    it "returns http success" do
      get 'show_matilda'
      expect(response).to be_success
    end
  end

end
