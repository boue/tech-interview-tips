class QuestionsController < ApplicationController
  before_action :set_question, only: [:edit, :update, :destroy]
  before_action :set_question_redirect, only: [:show]
  before_action :check_current_user, only: [:new, :edit, :update, :destroy ]

  def index 
    if params[:tag]
      @questions = Question.all
      @questions = @questions.tagged_with(params[:tag])
      @questions = @questions.paginate(:page => params[:page], :per_page => 10)
    elsif params[:search]  
      @questions = Question.paginate(:page => params[:page], :per_page => 10)
      @questions = @questions.search(params[:search])
    else
      @questions = Question.all
      @questions = @questions.paginate(:page => params[:page], :per_page => 10)
    end
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @user = User.find(current_user.id)
    @question = Question.new(question_params)
    @user.questions << @question
    if @question.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update_attributes(question_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to root_path
  end

  private

    def question_params
      params.require(:question).permit(:title, :tag_list)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_question_redirect
      @question = Question.friendly.find(params[:id])
      # If an old id or a numeric id was used to find the record, then
      # the request path will not match the post_path, and we should do
      # a 301 redirect that uses the current friendly id.
      if request.path != question_path(@question)
        redirect_to @question, status: :moved_permanently
      end
    end

    def set_question
      @question = Question.friendly.find(params[:id])
    end

    def check_current_user
      unless current_user
        redirect_to root_url, flash: { notice: "Please sign in first" }
      end
    end
end
