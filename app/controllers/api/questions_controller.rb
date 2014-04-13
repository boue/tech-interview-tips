class Api::QuestionsController < ApplicationController
  respond_to :json

  def index
    @questions = Question.all
    render json: @questions
  end
    # serializer: QuestionSerializer

# chrome extension json viewer
end
