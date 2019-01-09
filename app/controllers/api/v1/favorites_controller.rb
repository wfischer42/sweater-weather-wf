class Api::V1::FavoritesController < ApplicationController
  def create
    validate :current_location, :current_user do
      current_user.add_favorite(current_location)
    end
  end

  def index
    validate :current_user do
      render json: FavoritesSerializer.new(FavoritesFacade.new(current_user))
    end
  end

  def destroy
    validate :current_location, :current_user do
      current_user.remove_favorite(current_location)
    end
  end
end
