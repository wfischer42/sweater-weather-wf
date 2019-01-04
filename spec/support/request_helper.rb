require 'rails_helper'

module Request
  module JsonHelper
    def json
      JSON.parse(response.body)
    end
  end
end
