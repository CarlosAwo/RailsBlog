class Web::HomeController < Web::BaseController
  def home
    @articles = ArticleDecorator.decorate_collection(Article.all)
  end
end
