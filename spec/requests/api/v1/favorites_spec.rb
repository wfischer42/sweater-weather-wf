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
end
