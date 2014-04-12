class FavoritesController < ApplicationController

  def create
    favorite = Favorite.new
    question = Question.find(params[:question_id])
    favorite.user_id = current_user.id
    question.favorites << favorite
    if favorite.save
      redirect_to question_path(question)
    end
  end
end