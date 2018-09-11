class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @question = Question.all
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
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
