class Api::V1::SessionsController < ApplicationController
  def create
    if user = User.find_and_authenticate_by(login_params)
      render json: { api_key: user.token }
    else
      render json: { message: "Invalid Credentials" }, status: 401
    end
  end

  private
  def login_params
    @login_params ||= params.permit(:email, :password)
  end

end
