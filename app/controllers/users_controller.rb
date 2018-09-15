class UsersController < ApplicationController
  skip_before_action :verify_authentication
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @question = Question.order('created_at DESC').page(params[:page]).per(1)
  end

  def profile
    @user = current_user
   
  end
  def show
   
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      redirect_to new_user_path
    end
  end

  def edit
    if current_user.id != @user.id
      redirect_to @user
      flash[:error_message] = "You can only update your profile"
    end
  end

  def update
    if current_user.id != @user.id
      flash[:error_message] ="You can't update this user"
    else
      if @user.update(user_params)
        redirect_to @user
      else
        redirect_to @user
        flash[:error_message] ="Something went wrong"
      end
    end
  end
 

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :profile_pic, :api_token)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
