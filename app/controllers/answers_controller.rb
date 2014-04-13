class AnswersController < ApplicationController

  def show
    @answer = Answer.find params[:id]
  end

  # unneeded?
  def new
    @answer = Answer.new
  end

  def create
    question = Question.find(params[:answer][:question_id])
    answer = Answer.new answer_params
    question.answers << answer
    answer.user_id = current_user.id
    if answer.save
      redirect_to question_path(question)
    end
  end

  def edit
    @answer = Answer.find params[:id]
  end

  def update
    @answer = Answer.find params[:id]
    @question = Question.find(params[:answer][:question_id])
      if @answer.update_attributes answer_params
        redirect_to question_path(@question)
      else
        render :edit
      end
  end

  def destroy
    answer = Answer.find params[:id]
    question = Question.find(answer.question_id)
    answer.destroy
    redirect_to question_path(question)
  end

  private
  def answer_params
    params.require(:answer).permit(:content)
  end
end