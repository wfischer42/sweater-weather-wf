class GiffyService

  def initialize(query)
    @query = query
  end

  def self.get_gif(query)
    service = new(query)
    service.get_gif
  end

  def get_gif
    url = JSON.parse(response.body)["data"].sample["url"]
  end

  private
  attr_reader :query

  def response
    request_params = { api_key: ENV['GIFFY_KEY'], q: query, limit: 10,
                       offset: 0, rating: 'g', lang: 'en'}
    @response ||= conn.get('search') { |r| r.params = request_params }
  end

  def conn
    Faraday.new('https://api.giphy.com/v1/gifs/')
  end

end
