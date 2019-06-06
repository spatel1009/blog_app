require 'rails_helper'

RSpec.feature 'User Sign out' do
  before do
    @john = User.create!(email: 'test123@test.com', password: '123456')

    visit '/'
    click_link 'Log in'
    fill_in 'Email', with: 'test123@test.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  scenario 'Sign out successfully' do
    click_link 'Sign out'

    expect(page).to have_content('Signed out successfully')
    expect(page).to have_link('Log in')
    expect(page).to have_link('Sign up')
    expect(page).not_to have_link('Sign out')
    expect(page.current_path).to eq(root_path)
  end
end