class QuestionsController < ApplicationController

  def new
    @question = Question.new
  end

  def create
  end

end
