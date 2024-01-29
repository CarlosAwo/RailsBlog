class Api::V1::ArticlesController < Api::V1::AuthenticationController
  def index
    @articles = Article.all
    @articles = @articles.decorate
  end
end