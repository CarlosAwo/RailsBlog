class Web::ArticlesController < Web::AuthenticationController
  layout 'article', only: [:show]
  before_action :set_article, only: %i[show edit update destroy]

  skip_before_action :authenticate_user!, only: [:index]

  def index
    @articles = Article.all
    @per_page = 2
    @page = params[:page].to_i || 1
    @total_pages = (@articles.count.to_f / @per_page).ceil
    @articles = @articles.offset((@page - 1) * @per_page).limit(@per_page)
    @articles = @articles.decorate
  end

  def show
    @comment = @article.comments.build
    @article = @article.decorate
  end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to article_url(@article), notice: "Article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      redirect_to article_url(@article), notice: "Article was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy!
    redirect_to articles_url, notice: "Article was successfully destroyed."
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:name, :content, :picture)
  end
end
