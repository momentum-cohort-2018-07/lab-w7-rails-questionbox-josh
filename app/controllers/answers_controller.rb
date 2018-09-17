class AnswersController < ApplicationController
  skip_before_action :verify_authentication
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
    AnswerMailer.answer_noti(@question.user.email).deliver_now
    redirect_to @question
   else
    flash[:notice] = "Failed to submit answer"
    render 'new'
   end
  end

  def edit

  end

  def update
    @answer = Answer.find(params[:id])
    @question = @answer.question
    if current_user.id != @question.user_id
      redirect_to @question
      flash[:error_message] ="You can't mark answer"
    else
      if @answer.update(answer_params)
        redirect_to root_path
      else
        redirect_to @question
        flash[:error_message] ="Something went wrong"
      end
    end
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
