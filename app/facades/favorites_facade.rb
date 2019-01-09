class FavoritesFacade
  def initialize(user)
    @user = user
  end

  def forecasts
    user.favorites.map do |favorite|
      current_weather = Forecast.for_location(favorite).current
      { city:  favorite.city,
        state: favorite.state,
        current_weather: current_weather }
    end
  end

  def id
    user.token
  end

  private
  attr_reader :user
end
