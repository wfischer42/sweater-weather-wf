class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :current, :next, :hourly, :daily
end
