require 'rails_helper'

RSpec.describe "Api::V1::Favorites", type: :request do
  describe "POST /api/v1/favorites", :vcr do
    context "With a valid location & token" do
      before do
        post '/api/v1/users', params: { email:                 "em@email.com",
                                        password:              "bad-password",
                                        password_confirmation: "bad-password" }
      end

      it "adds a favorite" do
        user = User.last
        post '/api/v1/favorites', params: { city: "Denver", state: "CO",
                                            api_key: user.token }

        expect(response).to have_http_status(204)
        expect(user.favorites.first).to have_attributes(city: "Denver",
                                                        state: "CO")
      end
    end

    context "With an invalid location" do
      it "responds with invalid location message" do
        post '/api/v1/users', params: { email:                 "em@email.com",
                                        password:              "bad-password",
                                        password_confirmation: "bad-password" }

        post '/api/v1/favorites', params: { city: "Notacity", state: "Notastate",
                                           api_key: User.last.token }

        expect(response).to have_http_status(400)
        expect(json["message"]).to eq("Location was not found.")
      end
    end

    context "With an invalid token" do
      it "responds with invalid credentials message" do
        post '/api/v1/favorites', params: { city: "Denver", state: "CO" }

        expect(response).to have_http_status(401)
        expect(json["message"]).to eq("Invalid Credentials")
      end
    end
  end

  describe "GET /api/v1/favorites", :vcr do
    before do
      post '/api/v1/users', params: { email:                 "em@email.com",
                                      password:              "bad-password",
                                      password_confirmation: "bad-password" }
      user = User.last
      favorite = user.favorites.create(lat: 1, lon: 2,
                                       city: "Cleveland",
                                       state: "Ohio")
       get '/api/v1/favorites', params: { api_key: user.token }
    end
    let(:location) { Location.last }

    context "With a valid token" do
      it "responds with JSON 1.0" do
        expect(response).to be_successful
        expect(json).to be_a(Hash)
        expect(json["data"]["attributes"]["forecasts"].size).to eq 1
        expect(json["data"]["id"].to_i).to be_an(Integer)
        expect(json["data"]["type"]).to be_a(String)
        expect(json["data"]["attributes"]).to be_a(Hash)
      end

      it "Returns list of favorites with forecasts" do
        user = User.last
        expect(response).to have_http_status(200)
        forecasts = json["data"]["attributes"]["forecasts"]
        expect(forecasts[0]["city"]).to eq(location.city)
        expect(forecasts[0]["state"]).to eq(location.state)
        expect(forecasts[0]["current_weather"]).to be_a Hash
      end
    end

    context "With an invalid token" do
      it "responds with invalid credentials message" do
        get '/api/v1/favorites', params: { api_key: "1234" }

        expect(response).to have_http_status(401)
        expect(json["message"]).to eq("Invalid Credentials")
      end
    end
  end

  describe "DELETE /api/v1/favorites", :vcr do
    before do
      post '/api/v1/users', params: { email:                 "em@email.com",
                                      password:              "bad-password",
                                      password_confirmation: "bad-password" }
      user = User.last
      favorite = user.favorites.create(lat: 1, lon: 2,
                                       city: "Cleveland",
                                       state: "Ohio")
    end

    context "With a valid token" do
      it "removes the favorite" do
        expect(User.last.favorites[0].city).to eq("Cleveland")
        delete '/api/v1/favorites', params: { api_key: User.last.token,
                                              City:    "Cleveland",
                                              State:   "Ohio" }
        expect(response).to have_http_status(204)
        expect(User.last.favorites[0]).to be_nil
      end
    end

    context "With an invalid token" do
      it "responds with invalid credentials message" do
        delete '/api/v1/favorites', params: { api_key: "1234",
                                              location_name: "Ohio" }

        expect(response).to have_http_status(401)
        expect(json["message"]).to eq("Invalid Credentials")
      end
    end
  end

end
