require 'rails_helper'

RSpec.feature 'Show Articles' do

  before do
    @john = User.create!(email: 'test123@test.com', password: '123456')
    @sohel = User.create!(email: 'test1234@test.com', password: '1234567')
    @article1 = Article.create(title: 'The first article', body: 'The first body.', user_id: @john.id)

    visit '/'
    click_link('index-link')
  end

  scenario 'User clicks on title link and goes to show page' do

    expect(page.current_path).to eq(article_path(@article1))
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
  end

  scenario 'to non-signed in user hide the Edit and Delete buttons' do
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).not_to have_link('Edit Article')
    expect(page).not_to have_link('Delete Article')
  end

  scenario 'to signed in user show the Edit and Delete buttons only on their articles' do
    login_as(@john)
    visit '/'
    click_link('index-link')

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_link('Edit Article')
    expect(page).to have_link('Delete Article')
  end

  scenario 'to signed in user do not show the Edit and Delete buttons on others articles' do
    login_as(@sohel)
    visit '/'
    click_link('index-link')

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).not_to have_link('Edit Article')
    expect(page).not_to have_link('Delete Article')
  end

end