class AnswersController < ApplicationController

  def show
    @answer = Answer.find params[:id]
  end

  def new
    @answer = Answer.new
  end

  def create
    user = User.find(current_user.id)
    question = Question.find(params[:answer][:question_id])
    answer = Answer.new(answer_params)
    user.answers << answer
    question.answers << answer
    if answer.save
      redirect_to question_path(question)
    else
      redirect_to question_path(question), flash: { notice: "Answer can't be blank."}
    end
  end

  def update
    @answer = Answer.find params[:id]
    @question = @answer.question
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