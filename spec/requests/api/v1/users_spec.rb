require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "POST api/v1/users", :vcr do
    before do
      post '/api/v1/users', params: { email:                 "em@email.com",
                                      password:              "bad-password",
                                      password_confirmation: "bad-password" }
    end

    it "responds with JSON" do
      expect(response).to be_successful
      expect(json).to be_a(Hash)
    end

    it "generates a valid API key" do
      expect(json["api_key"]).to be_a(String)
      expect(json["api_key"]).to eq(User.first.token())
    end
  end
end
