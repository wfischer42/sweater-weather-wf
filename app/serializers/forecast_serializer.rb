class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :current, :next, :hourly, :daily
end
