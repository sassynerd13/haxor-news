class CommentsController < ApplicationController
  before_action :get_article_and_comments
  before_action :authenticate_user!, only: :create

  def index
    @comment = Comment.new
    respond_with @comments
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.article = @article
    @comment.user = current_user

    respond_to do |wants|
      wants.html do
        if @comment.save
          redirect_to [@article, :comments], notice: 'Comment added!'
        else
          flash.now[:alert] = @comment.errors.full_messages.join(', ')
          render :index
        end
      end

      wants.json do
        if @comment.save
          render json: @comment, status: :created, location: [@article, :comments]
        else
          respond_with @comment
        end
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def get_article_and_comments
    @article = Article.find(params[:article_id])
    @comments = @article.comments.order(score: :desc)
  end
end
