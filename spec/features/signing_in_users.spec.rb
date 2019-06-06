require 'rails_helper'

RSpec.feature 'User Sign in' do
  before do
    @john = User.create!(email: 'test123@test.com', password: '123456')
  end

  scenario 'with valid credentials' do
    visit '/'
    click_link 'Log in'
    fill_in 'Email', with: 'test123@test.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
    expect(page).not_to have_link('Log in')
    expect(page).not_to have_link('Sign up')
  end
end 