require 'rails_helper'

RSpec.describe "Api::V1::Forecast", type: :request do
  describe "GET api/v1/forecast", :vcr do

    context "With a valid location" do
      before do
        get '/api/v1/forecast', params: {city: "Denver", state: "CO"}
      end
      it "responds with JSON 1.0" do
        expect(response).to be_successful
        expect(json).to be_a(Hash)
        expect(json["data"]["id"].to_i).to be_an(Integer)
        expect(json["data"]["type"]).to be_a(String)
        expect(json["data"]["attributes"]).to be_a(Hash)
      end

      describe "response data" do
        subject(:forecast) { json["data"]["attributes"] }
        it "includes current weather data" do
          expect(forecast["current"]).to be_a(Hash)
          expect(forecast["current"]).to_not be_empty
        end

        it "includes upcoming weather summary" do
          expect(forecast["next"]).to be_a(Hash)
          expect(forecast["next"]["summary"]).to_not be_nil
        end
      end
    end

    context "With an invalid location" do
      it "responds with invalid location message" do
        get '/api/v1/forecast', params: {city: "Notacity", state: "Notastate"}
        expect(json["message"]).to eq("Location was not found.")
      end
    end
  end
end
