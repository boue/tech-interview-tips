class UsersController < ApplicationController
  before_action :check_current_user, only: [:show]

  def index
    @users = User.find(:all).sort{|u1,u2| u2.answers.count <=> u1.answers.count }
  end

  def show
    @user = User.find params[:id]
  end

  private

  def check_current_user
    unless current_user == User.find(params[:id])
      redirect_to root_url, flash: { warning: "Please sign in to view your Interview Prep area" }
    end
  end
end

