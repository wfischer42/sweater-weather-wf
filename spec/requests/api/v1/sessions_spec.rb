require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do
  describe "POST api/v1/sessions", :vcr do
    context "with valid credentials" do
      before do
        user_params_hash = { email: 'em@email.com', password: "bad-password" }
        User.create(user_params_hash)
        post '/api/v1/sessions', params: user_params_hash
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

    context "with invalid credentails" do
      describe "incorrect password" do
        before do
          User.create({ email: 'e@mail.co', password: "asdf" })
          post '/api/v1/sessions', params: { email: 'e@mail.co', password: "as" }
        end

        it "responds with 401 status" do
          expect(response).to have_http_status(401)
        end

        it "responds with message in JSON" do
          expect(json["message"]).to eq("Invalid Credentials")
        end
      end

      describe "no user with that email" do
        before do
          post '/api/v1/sessions', params: { email: '1@m.co', password: "asdf" }
        end

        it "responds with 401 status" do
          expect(response).to have_http_status(401)
        end

        it "responds with message in JSON" do
          expect(json["message"]).to eq("Invalid Credentials")
        end
      end
    end
  end
end
