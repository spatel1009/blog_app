require 'rails_helper'

RSpec.feature 'Editing an article' do

  before do
    @article = Article.create(title: 'The first article', body: 'The first body.')

    visit '/'
    click_link('index-link')
  end

  scenario 'A user updates an article' do
    click_link('Edit Article')

    fill_in "Title", with: "Updated first article"
    fill_in "Body", with: "Updated first body."
    click_button "Update Article"

    expect(page).to have_content("Article has been updated!")
    expect(page).to have_content("Updated first article")
    expect(page.current_path).to eq(article_path(@article))
  end

  scenario 'A user fails to update an article' do
    click_link('Edit Article')

    fill_in "Title", with: "Updated first article"
    fill_in "Body", with: ""
    click_button "Update Article"

    expect(page).to have_content("Article has not been updated!")
    expect(page.current_path).to eq(article_path(@article))
  end

end