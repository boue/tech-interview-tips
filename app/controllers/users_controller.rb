class UsersController < ApplicationController
  before_action :check_current_user, only: [:show]

  def index
    @users = User.find(:all).sort{|u1,u2| u2.answers.count <=> u1.answers.count }
  end

  def show
    @user = User.find params[:id]
    @questions = @user.questions
    #Client.joins(:orders).where('orders.created_at' => time_range)
    @answered_questions = Question.joins(:answers).where('answers.user_id' => @user.id)
  end

  private

  def check_current_user
    unless current_user == User.find(params[:id])
      redirect_to root_url, flash: { warning: "Please sign in to view your Interview Prep area" }
    end
  end
end

