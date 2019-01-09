class FavoritesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :forecasts
end
