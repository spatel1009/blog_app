module ArticlesHelper

  def index_content
    if @articles.empty? 
      default = 'No Articles Created'
      content_tag(:h1, default, id: 'no-articles')
    else
      render partial: 'list_articles'
    end
  end

end
