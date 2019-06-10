require 'rails_helper'

RSpec.feature 'Deleting an article' do

  before do
    @john = User.create!(email: 'test123@test.com', password: '123456')
    
    @article = Article.create(title: 'The first article', body: 'The first body.', user_id: @john.id)
    login_as(@john)
  end

  scenario 'A user deletes an article' do
    visit '/'
    click_link('index-link')
    click_link('Delete Article')

    expect(page).to have_content('Article has been deleted')
    expect(current_path).to eq(articles_path)
  end
end