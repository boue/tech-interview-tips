class KudosController < ApplicationController

  def create
    @kudo = Kudo.new
    if params[:answer_id]
      @answer = Answer.find(params[:answer_id])
      unless @answer.kudos.find_by(user_id: current_user.id)
        @kudo.user_id = current_user.id
        @answer.kudos << @kudo
        @kudo.save
      end
      respond_to do |format|
        format.json {render json: {id: @answer.id, kudos_count: @answer.kudos.count}}
        format.html { redirect_to question_path(@answer.question) }
      end
    elsif params[:question_id]
      @question = Question.find(params[:question_id])
      unless @question.kudos.find_by(user_id: current_user.id)
        @kudo.user_id = current_user.id
        @question.kudos << @kudo
        @kudo.save
      end
      respond_to do |format|
        format.json {render json: {kudos_count: @question.kudos.count}}
        format.html { redirect_to question_path(@question) }
      end
    else
      redirect_to root_path, flash: { notice: "Kudos create was unsuccessful" }
    end
  end

end

# def create
#   @kudo = Kudo.new
#   @kudosible = params[:kudosible_type].capitalize.constantize.find(params[:kudosible_id])
# # If there's not already a kudo for this kudosible for this user:
#   if params[:kudosible_type].capitalize.constantize == "Answer" 
#   || params[:kudosible_type].capitalize.constantize == "Question"
#     unless @kudosible.kudos.find_by(user_id: current_user.id)
#       @kudo.user_id = current_user.id
#       @kudosible.kudos << @kudo
#       @kudo.save
# # If kudosible type = Answer
#     if params[:kudosible_type].capitalize.constantize == "Answer" 
#       respond_to do |format|
#         format.json {render json: {id: @answer.id, kudos_count: @answer.kudos.count}}
#         format.html { redirect_to question_path(@kudosible.question) }
#       end
#     elsif params[:kudosible_type].capitalize.constantize == "Question"  
# # If kudosible type = to Question
#       respond_to do |format|
#         format.json {render json: {kudos_count: @kudosible.kudos.count}}
#         format.html { redirect_to question_path(@kudosible) }
#       end
#     end
#   else
#     redirect_to root_path, flash: { notice: "Kudos create was unsuccessful" }
#   end
# end

