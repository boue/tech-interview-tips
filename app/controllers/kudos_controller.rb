class KudosController < ApplicationController

  def create
    @kudo = Kudo.new
    @question = Question.find(params[:question_id])
    if @question.kudos.where(user_id: current_user.id).count == 0
      @kudo.user_id = current_user.id
      @question.kudos << @kudo
      @kudo.save
    end
    redirect_to question_path(@question)
  end

end