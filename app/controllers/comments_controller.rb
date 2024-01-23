class CommentsController < ApplicationController
  before_action :set_commentable

  def create
    @comment = @commentable.comments.new(comment_params)

    if @comment.save
      redirect_to(request.referer || @commentable || root_path, notice: 'Comment created successfully.')
    else
      redirect_to(request.referer || @commentable || root_path, alert: 'Unable to Create comment.')
    end
  end

  private

  def set_commentable
    if params[:article_id]
      @commentable = Article.find(params[:article_id])
    elsif params[:comment_id]
      @commentable = Comment.find(params[:comment_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:body).with_defaults(user: current_user)
  end
end
