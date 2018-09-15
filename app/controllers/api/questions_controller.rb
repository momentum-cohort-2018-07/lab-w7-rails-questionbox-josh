class API::QuestionsController < ApplicationController
  skip_before_action :verify_authentication, only: [:index, :show]
  before_action :set_question, only: [:show, :destroy]
  def index
    @questions = Question.all
  end

  def create
  end

  def show
  end

  def destroy
  end

  private

  def question_params
    params.require(:question).permit(:question, :title, :user_id)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end