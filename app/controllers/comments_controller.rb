class CommentsController < ApplicationController
  before_action :set_article

  def index
    @comments = @article.comments
  end

  def create
    @comment = @article.comments.new(comment_params)

    if @comment.save
      puts "HELOOOOOOOOOOOOOO"
      redirect_to article_url(@article), notice: "Comment was successfully created."
    else
      puts "WOOOOOOOOOOOOOOOO"
      render "articles/show", article: @article, status: :unprocessable_entity
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
