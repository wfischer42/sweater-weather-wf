require 'rails_helper'

RSpec.describe "Api::V1::Gifs", type: :request do
  describe "GET api/v1/gifs", :vcr do
    before do
      get '/api/v1/gifs', params: { city: "Denver", state: "CO" }
    end

    it "responds with JSON 1.0" do
      expect(response).to be_successful
      expect(json).to be_a(Hash)
      expect(json["data"]["id"].to_i).to be_an(Integer)
      expect(json["data"]["type"]).to be_a(String)
      expect(json["data"]["attributes"]).to be_a(Hash)
    end
  end
end
