class Forecast
  include ForecastFilter
  attr_reader :id

  def initialize(raw_data, id)
    @raw_data = raw_data
    @id = id
  end

  def self.for_location(location)
    raw_data = DarkskyService.forecast(location)
    self.new(raw_data, location.id)
  end

  def hourly
    filter_set(raw_data[:hourly][:data][0..11])
  end

  def daily
    filter_set(raw_data[:daily][:data][0..6])
  end

  def current
    filter_item(raw_data[:currently])
  end

  def next
    raw_data[:hourly].slice(:summary, :icon)
  end

  private
  attr_reader :raw_data

  def filter_set(dataset)
    dataset.map { |entry| filter_item(entry)}
  end

  def filter_item(entry)
    entry.slice(*forecast_filter)
  end
end
