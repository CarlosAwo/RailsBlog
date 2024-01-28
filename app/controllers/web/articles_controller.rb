class Web::ArticlesController < Web::AuthenticationController
  layout 'article', only: [:show]
  before_action :set_article, only: %i[show edit update destroy]

  skip_before_action :authenticate_user!, only: [:index]

  def index
    @articles = Article.all
    @per_page = 2
    @page = params[:page].to_i || 1
    @articles_grouped_by_pages = @articles.each_slice(@per_page).to_a
    @total_pages = @articles_grouped_by_pages.length
    @articles = @articles_grouped_by_pages[@page - 1].nil? ? [] : @articles_grouped_by_pages[@page - 1]
    # @articles = @articles.offset((@page - 1) * @per_page).limit(@per_page)
    console
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
