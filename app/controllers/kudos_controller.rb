class KudosController < ApplicationController

  def create
    kudo = Kudo.new
    question = Question.find(params[:question_id])
    kudo.user_id = current_user.id
    question.kudos << kudo
    if kudo.save
      redirect_to question_path(question)
    end
  end
end