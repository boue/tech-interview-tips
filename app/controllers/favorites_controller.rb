class FavoritesController < ApplicationController

  def create
    favorite = Favorite.new
    question = Question.find(params[:question_id])
    if question.favorites.where(user_id: current_user.id).count == 0
      favorite.user_id = current_user.id
      question.favorites << favorite
      favorite.save
    end
    redirect_to question_path(question)
  end
end