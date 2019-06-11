module ArticlesHelper

  def index_content
    if @articles.empty? 
      default = 'No Articles Created'
      content_tag(:h1, default, id: 'no-articles')
    else
      render partial: 'list_articles'
    end
  end

  def article_owner
    if @article.user == current_user then render partial: 'edit_delete' end
  end

  def user_id?
    if current_user != nil then render partial: 'create_article' end
  end
end
