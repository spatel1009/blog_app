require 'rails_helper'

RSpec.feature 'Deleting an article' do

  before do
    @article = Article.create(title: 'The first article', body: 'The first body.')
  end

  scenario 'A user deletes an article' do
    visit '/'
    click_link('index-link')
    click_link('Delete Article')

    expect(page).to have_content('Article has been deleted')
    expect(current_path).to eq(articles_path)
  end
end