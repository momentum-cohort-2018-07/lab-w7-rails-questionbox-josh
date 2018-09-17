class API::QuestionsController < ApplicationController
  skip_before_action :verify_authentication, only: [:index, :show]
  before_action :set_question, only: [:show, :destroy]
  def index
    @questions = Question.all
  end

  def create
      @question = Question.new(title: question_params[:title], body: question_params[:body], user_id: api_token_user.id)
      if @question.save
        render :show, status: :created, location: api_question_url(@question)
      else
       render json: { "error": "Unable to create question" }, status: :unprocessable_entity
      end
  end

  def show
  end

  def destroy
    if api_token_user.id == @question.user_id
      @question.destroy
      render json: {"notice": "Question has been deleted"}, status: :accepted
    else
      render json: {"error": "Can't delete questions that are not yours"}, status: :unprocessable_entity
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end