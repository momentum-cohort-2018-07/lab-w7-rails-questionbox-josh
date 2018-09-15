class QuestionsController < ApplicationController
  skip_before_action :verify_authentication
  before_action :set_question, only: [:show, :destroy]
  def index
    @questions = Question.all
  end

  def new
    if current_user
      @question = Question.new
    else
      flash[:notice] = "You must be logged in to create post"
      redirect_to new_session_path
    end
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to @question
   else
       render 'new'
   end
  end

  def show
    @answer = @question.answers
  end

  def destroy
    if current_user.id == @question.user_id 
    @question.destroy
    redirect_to root_path
    else
      flash[:notice] = "Must be your question to delete"
    end
  end

  private

  def question_params
    params.require(:question).permit(:question, :title, :user_id)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
