class Api::V1::FavoritesController < ApplicationController
  def create
    validate :current_location, :current_user do
      current_user.add_favorite(current_location)
    end
  end
end
