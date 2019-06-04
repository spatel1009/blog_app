class ArticlesController < ApplicationController
  # before_action :set_article
  
  def index
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.create!(article_params)

    flash[:success] = 'Article has been created'
    redirect_to articles_path
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
