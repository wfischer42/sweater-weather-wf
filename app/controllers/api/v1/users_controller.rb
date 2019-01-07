class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(new_user_params) if passwords_match?
    render json: { api_key: user.token }
  end

  private
  def new_user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def passwords_match?
    params[:password] == params[:password_confirmation]
  end
end
