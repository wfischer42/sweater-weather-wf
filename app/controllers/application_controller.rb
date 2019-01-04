class ApplicationController < ActionController::API
  def location_params
    params.permit(:city, :state)
  end
end
