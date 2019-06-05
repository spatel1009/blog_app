require 'rails_helper'

RSpec.feature 'Show Articles' do

  before do
    @article1 = Article.create(title: 'The first article', body: 'The first body.')

    visit '/'
  end

  scenario 'User clicks on title link and goes to show page' do
    click_link('index-link')

    expect(page.current_path).to eq(article_path(@article1))
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
  end

end