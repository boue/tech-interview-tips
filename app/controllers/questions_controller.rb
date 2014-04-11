class QuestionsController < ApplicationController

  def show
    @question = Question.find params[:id]
  end

  def new
    @question = Question.new
  end

  def create
    p params
    @question = Question.new params[:question]
    if @question.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

end
