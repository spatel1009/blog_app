class CommentsController < ApplicationController
  before_action :set_article
  before_action :authenticate_user!

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

  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
