require 'rails_helper'

RSpec.describe "Api::V1::Forecast", type: :request do
  describe "GET api/v1/forecast" do
    it "works! (now write some real specs)" do
      get '/api/v1/forecast', params: {city: "Denver", state: "CO"}
      expect(response).to be_success
      expect(json).to be_a(Hash)
    end
  end
end
