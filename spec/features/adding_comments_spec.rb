require 'rails_helper'

RSpec.feature 'Adding comments to Articles' do
  before do
    @john = User.create(email: 'test@test.com', password: 'password')
    @sohel = User.create(email: 'test1@test.com', password: 'password1')
    @article = Article.create!(title: 'Title One', body: 'Body 1', user: @john)
  end

  scenario 'premits a signed in user to write a comment' do
    login_as(@sohel)
    visit '/'

    click_link('index-link')
    fill_in 'New Comment', with: 'An amazing article'
    click_button 'Add Comment'

    expect(page).to have_content('An amazing article')
    expect(current_path).to eq(article_comments_path(@article))
  end
end