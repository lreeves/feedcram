require 'rails_helper'

describe 'signing feature', type: :feature do
  before do
    User.create!(email: 'test@example.com', password: 'xxx')
  end

  it 'signs a valid user in' do
    visit '/login'

    fill_in 'E-Mail Address', with: 'test@example.com'
    fill_in 'Password', with: 'xxx'

    click_button 'Login'
    expect(page).to have_content 'Account'
  end

  it 'rejects a user with an invalid password' do
    visit '/login'

    fill_in 'E-Mail Address', with: 'test@example.com'
    fill_in 'Password', with: 'yyy'

    click_button 'Login'
    expect(page).to have_content 'Incorrect login information'
  end
end
