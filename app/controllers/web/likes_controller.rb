# app/controllers/likes_controller.rb
class Web::LikesController < Web::AuthenticationController
  before_action :set_likeable

  def create
    @like = @likeable.likes.build(user: current_user)

    respond_to do |format|
      if @like.save
        format.html { redirect_to(request.referer || @likeable || root_path, notice: 'You liked this.') }
        format.turbo_stream
      else
        redirect_to(request.referer || @likeable || root_path, alert: 'Unable to like.')
      end
    end
  end

  def destroy
    @like = @likeable.likes.find_by(user: current_user)
    @like.destroy

    respond_to do |format|
      format.html { redirect_to(request.referer || @likeable || root_path, notice: 'You unliked this.')}
      format.turbo_stream
    end
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
