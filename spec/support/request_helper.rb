require 'rails_helper'

module Requests
  module JsonHelper
    def json
      JSON.parse(response.body)
    end
  end
end
