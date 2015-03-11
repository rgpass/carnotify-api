class Api::V1::UsersController < ApplicationController
  respond_to :json

  def show
    respond_with User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    random_token = User.new_remember_token
    user.remember_token = User.digest(random_token)
    if user.save
      sign_in user
      render json: user, status: 201#, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      render json: user, status: 200#, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head 204
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end