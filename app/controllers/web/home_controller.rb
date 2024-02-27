class Web::HomeController < Web::BaseController
  def home
    @articles = ArticleDecorator.decorate_collection(Article.last(8))
    @subscriber = Subscriber.new
  end
end
