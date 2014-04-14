class ActionsController < ApplicationController
  def index
    @actions = Action.all
    @actions = @actions.paginate(:page => params[:page], :per_page => 10)
  end
end