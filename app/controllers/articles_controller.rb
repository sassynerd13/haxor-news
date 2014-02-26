class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @articles = Article.order(score: :desc)
    respond_with @articles
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)

    respond_to do |wants|
      wants.html do
        if @article.save
          redirect_to root_path, notice: 'Article submitted!'
        else
          flash.now[:alert] = @article.errors.full_messages.join(', ')
          render :new
        end
      end

      wants.json do
        if @article.save
          # respond_with throws a fit if the resource has no `show` route
          render json: @article, status: :created, location: [@article, :comments]
        else
          respond_with @article
        end
      end
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :url)
  end
end
