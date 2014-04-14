class UsersController < ApplicationController
  before_action :check_current_user, only: [:show]

  def index
    @users = User.find(:all).sort{|u1,u2| u2.questions.count <=> u1.questions.count }
  end

  def show
    @user = User.find params[:id]
  end

  private

  def check_current_user
    unless current_user
      redirect_to root_url, flash: { notice: "Please sign in first" }
    end
  end
end

