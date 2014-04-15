class FavoritesController < ApplicationController

  def create
    favorite = Favorite.new
    question = Question.find(params[:question_id])
    if question.favorites.where(user_id: current_user.id).count == 0
      favorite.user_id = current_user.id
      question.favorites << favorite
      favorite.save
    end
    respond_to do |format|
      format.json {render json: {fav_count: question.favorites.count}}
      format.html { redirect_to question_path(question) }
    end
  end

  def destroy
    favorite = Favorite.find(params[:favorite_id])
    favorite.destroy
    redirect_to user_path(User.find(params[:id]))
  end
end