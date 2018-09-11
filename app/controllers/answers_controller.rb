class AnswersController < ApplicationController
  before_action :set_answer, only: [:edit, :destroy]
  
  def new
    if current_user
      @answer = Answer.new
      @question = Question.find(params[:question_id])
    else
      flash[:notice] = "You Must be logged in to Answer"
    end
  end

  def create
   @question = Question.find(params[:question_id])
   @answer = @question.answers.create(answer_params)
   if @answer.save
    redirect_to @question
   else
    flash[:notice] = "Failed to submit answer"
    render 'new'
   end
  end

  def edit

  end

  def destroy
  end

  private 

  def answer_params
    params.require(:answer).permit(:solution, :correct_answer, :user_id, :question_id)
  end

  def set_answer
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end
end
