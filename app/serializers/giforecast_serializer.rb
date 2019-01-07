class GiforecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :daily_forecasts, :id, :copyrite
end
