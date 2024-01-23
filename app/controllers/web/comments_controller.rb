class Web::CommentsController < Web::AuthenticationController
  before_action :set_commentable

  def create
    @comment = @commentable.comments.new(comment_params)

    if @comment.save
      redirect_to(request.referer || @commentable || root_path, notice: 'You commentd this.')
    else
      redirect_to(request.referer || @commentable || root_path, alert: 'Unable to comment.')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).with_defaults(user: current_user)
  end

  def set_commentable
    if params[:article_id]
      @commentable = Article.find(params[:article_id])
    elsif params[:comment_id]
      @commentable = Comment.find(params[:comment_id])
    end
  end
end
