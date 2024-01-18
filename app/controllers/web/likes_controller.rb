# app/controllers/likes_controller.rb
class Web::LikesController < Web::AuthenticationController
  before_action :set_likeable

  def create
    @like = @likeable.likes.build(user: current_user)

    if @like.save
      redirect_to @likeable, notice: 'You liked this.'
    else
      redirect_to @likeable, alert: 'Unable to like.'
    end
  end

  def destroy
    @like = @likeable.likes.find(params[:id])
    @like.destroy

    redirect_to @likeable, notice: 'You unliked this.'
  end

  private

  def set_likeable
    if params[:article_id]
      @likeable = Article.find(params[:article_id])
    elsif params[:comment_id]
      @likeable = Comment.find(params[:comment_id])
    end
  end
end
