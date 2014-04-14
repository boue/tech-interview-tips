class CommentsController < ApplicationController

  def show
    @comment = Comment.find params[:id]
  end

  def new
    @comment = Comment.new
  end

  def create
    question = Question.find(params[:comment][:question_id])
    answer = Answer.find(params[:comment][:answer_id])
    comment = Comment.new comment_params
    comment.user_id = current_user.id
    answer.comments << comment
    if comment.save
      redirect_to question_path(question)
    else
      redirect_to question_path(question), flash: { notice: "Comment can't be blank."}
    end
  end

  def edit

  end

  def update

  end

  def destroy
    comment = Comment.find params[:id]
    comment.destroy
    redirect_to question_path(comment.commentable.question_id)
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
