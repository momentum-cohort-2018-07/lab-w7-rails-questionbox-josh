class API::UsersController < ApplicationController
  skip_before_action :verify_authentication, only: [:create]
  before_action :set_user, only: [:show, :destroy, :update]
  def index
    @users = User.all
  end

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
      render json: {"error": "Invalid"}, status: :unprocessable_entity
    end
  end

  def destroy
    if api_token_user.id == @user.id
      @user.destroy
      render json: {"notice": "User has been deleted"}, status: :accepted
    else
      render json: {"error": "You don't have permissions to delete this account"}, status: :unprocessable_entity
    end
  end

  def update
    if api_token_user.id == @user.id
      @user.update(user_params)
      render :profile, status: :updated, location: api_profile_path
    else
      render json: {"error": "You don't have permissions to update this account"}, status: :unauthorized
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :profile_pic)
  end
end