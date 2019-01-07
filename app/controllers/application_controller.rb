class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def current_user
    @current_user ||= User.find_by(token: params[:api_key])
  end

  def current_location
    @current_location ||= Location.fetch(location_params)
  end

  def location_params
    params.permit(:city, :state)
  end

  def failure_messages
    { current_user:
      { json: { message: "Invalid Credentials" },
                          status: 401 },
      current_location:
      { json: { message: "Location was not found." },
                          status: 400 } }
  end

  def invalid_response(type)
    return failure_messages[type]
  end

  def validate(*validations)
    validations.each do |validation|
      send(validation) || render(invalid_response(validation))
    end
    yield if validations.all? { |validation| send(validation) }
  end
end
