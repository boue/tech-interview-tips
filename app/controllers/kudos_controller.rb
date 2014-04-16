class KudosController < ApplicationController
  def create
    kudo = Kudo.new
    if params[:kudosible_type] && params[:kudosible_id]
      kudosible = params[:kudosible_type].capitalize.constantize.find(params[:kudosible_id])
      unless kudosible.kudos.find_by(user_id: current_user.id)
        kudo.user_id = current_user.id
        kudosible.kudos << kudo
        kudo.save
      end
      question = kudosible.respond_to?(:question) ? kudosible.question : kudosible
      respond_to do |format|
        format.json {render json: {id: kudosible.id, kudos_count: kudosible.kudos.count}}
        format.html { redirect_to question_path(question) }
      end
    else
      redirect_to root_path, flash: { notice: "Kudos create was unsuccessful" }
    end
  end
end