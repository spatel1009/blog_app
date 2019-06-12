class CommentsController < ApplicationController
  before_action :set_article
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :update]

  def new
    @comment = Comment.new
    respond_to do |f|
      f.js 
    end
  end

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      ActionCable.server.broadcast 'comments',
        render(partial: 'comments/comment', object: @comment)
      flash[:notice] = 'Comment has been created'
    else
      flash.now[:alert] = 'Comment has not been created'
    end
  end

  def edit
    respond_to do |f|
      f.js
    end
  end

  def update
    if @comment.update!(comment_params)
      ActionCable.server.broadcast 'comments',
        render(partial: 'comments/comment', object: @comment)
      flash[:notice] = 'Comment has been updated'
    else
      flash.now[:alert] = 'Comment has not been updated'
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end
  
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
