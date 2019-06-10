require 'rails_helper'

RSpec.feature 'Show Articles' do

  before do
    @john = User.create!(email: 'test123@test.com', password: '123456')
    @article1 = Article.create(title: 'The first article', body: 'The first body.', user_id: @john.id)

    visit '/'
  end

  scenario 'User clicks on title link and goes to show page' do
    click_link('index-link')

    expect(page.current_path).to eq(article_path(@article1))
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
  end

end