class KudosController < ApplicationController

  def create
    @kudo = Kudo.new
    @question = Question.find(params[:question_id])
    if has_not_given_kudos?
      @kudo.user_id = current_user.id
      @question.kudos << @kudo
      @kudo.save
    end
    redirect_to question_path(@question)
  end

  private
  def has_not_given_kudos?
    bool = false
    @question.kudos.each do |kudo|
      if @kudo.user_id == current_user.id
        bool = true
      else
        bool = false
      end
    end
    bool
  end

end