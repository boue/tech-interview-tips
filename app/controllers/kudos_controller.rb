class KudosController < ApplicationController

  def create
    @kudo = Kudo.new
    if params[:answer_id]
      @answer = Answer.find(params[:answer_id])
      Kudo.assign(@answer, current_user, @kudo)
      respond_to do |format|
        format.json {render json: {id: @answer.id, kudos_count: @answer.kudos.count}}
        format.html { redirect_to question_path(@answer.question) }
      end

    elsif params[:question_id]
      @question = Question.find(params[:question_id])
      Kudo.assign(@question, current_user, @kudo)
      respond_to do |format|
        format.json {render json: {kudos_count: @question.kudos.count}}
        format.html { redirect_to question_path(@question) }
      end
    else
      redirect_to root_path, flash: { notice: "Kudos create was unsuccessful" }
    end
  end

end