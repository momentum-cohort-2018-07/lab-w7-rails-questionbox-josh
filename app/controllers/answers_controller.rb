class AnswersController < ApplicationController
  def new
    if current_user
      @answer = Answer.new
    else
      flash[:notice] = "You Must be logged in to Answer"
  end

  def create
   
  end

  def edit

  end

  private 

  def answer_params
    params.require(:answer).permit(:answer, :correct_answer, :usr_id, :question_id)
  end


end
