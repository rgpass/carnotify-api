class Api::V1::SessionsController < ApplicationController

  def index
    render json: current_user, status: 200
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      render json: user, status: 200#, location: [:api, user]
    else
      render json: { errors: 'Invalid email or password' }, status: 422
    end
  end

  def destroy
    sign_out
    head 204
  end
end
