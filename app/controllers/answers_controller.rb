class AnswersController < ApplicationController

  def show
    @answer = Answer.find params[:id]
  end

  def new
    @answer = Answer.new
  end

  def create
    question = Question.find(params[:answer][:question_id])
    @answer = Answer.new answer_params
    @answer.user_id = current_user.id
    @answer.question_id = question.id
    if @answer.save
      redirect_to question_path(question)
    end
  end

  def edit

  end

  def update

  end

  private
  def answer_params
    params.require(:answer).permit(:content)
  end
end