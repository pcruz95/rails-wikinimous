class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :new, :update, :create, :destroy]

  def index
    @articles = Article.first(20)
  end

  def search
    start_time = Time.now()
    @articles_where = Article.where("articles.content LIKE ?", "%#{params[:q]}%")
    @time_where = ((Time.now() - start_time) * 1000).round(2)

    start_time = Time.now()
    @articles = Article.search(params[:q])
    @time_pg = ((Time.now() - start_time) * 1000).round(2)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save
    redirect_to articles_path
  end

  def edit
  end

  def update
    @article.update(article_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
