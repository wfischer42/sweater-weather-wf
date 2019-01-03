class Forecast
  attr_reader :data, :id
  def initialize(data, id)
    @data = data
    @id = id
  end

  def self.for_city_state(location)
    data = DarkskyService.get_forecast(location)
    self.new(data, location.id)
  end
end
