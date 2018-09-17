class API::AnswersController < ApplicationController
  before_action :set_answer, only: [:update, :destroy]

  def create
    @question = Question.find(params[:question_id])
   @answer = @question.answers.create(solution: answer_params[:solution], correct_answer: false, question_id: answer_params[:question_id], user_id: api_token_user.id )
   if @answer.save
    render "api/questions/show", status: :created, location: api_question_url(@question)
   else
    render json: {"error": "failed to create answer"}, status: :unprocessable_entity
   end
  end

  def update
    @question_id = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @question = @answer.question
    if api_token_user.id != @question.user_id
      render json: {"error": "You can't mark answer"}, status: :unauthorized
    else
      if @answer.update(answer_params)
        render "api/questions/show", status: :updated, location: api_question_url(@question_id)
      else
        render json: {"error": "Could not update"}, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if api_token_user.id == @answer.user_id
      @answer.destroy
      render json: {"notice": "Question has been deleted"}, status: :accepted
    else
      render json: {"error": "Can't delete questions that are not yours"}, status: :unprocessable_entity
    end
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