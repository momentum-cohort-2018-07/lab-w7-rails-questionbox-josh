class API::UsersController < ApplicationController
  skip_before_action :verify_authentication, only: [:create]
  before_action only: [:show]
  def show
  end

  def profile
    @user = api_token_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
    render json: @user
    else
      render json: {"error": "Invalid"}
    end
  end

  def destroy
    if api_token_user.id == @user.id
      @user.destroy
    else
      render json: {"error": "You don't have permissions to delete this account"}
    end
  end

  def update
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :profile_pic)
  end
end