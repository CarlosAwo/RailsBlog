class Web::HomeController < Web::BaseController
  def home
    @articles = Article.all
  end
end
