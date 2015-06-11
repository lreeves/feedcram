require 'rails_helper'

describe 'creating an account', type: :feature do
  context 'when registrations are disabled' do
    before do
      allow(SETTINGS).to receive(:[]).with(:allow_registrations).and_return false
    end

    it 'does not present a create account button' do
      visit '/'
      expect(page).to_not have_content 'Create Account'
    end

    it 'does not allow the account creation page to be accessed' do
      visit '/users/new'
      expect(page.status_code).to eq(403)
    end
  end

  context 'when registrations are enabled' do
    before do
      allow(SETTINGS).to receive(:[]).with(:allow_registrations).and_return true
    end

    it 'presents a create account button' do
      visit '/'
      expect(page).to have_content 'Create Account'
    end

    it 'allows a user to be created' do
      visit '/users/new'
      expect(page).to have_content 'E-mail'

      fill_in 'user_email', with: 'test@example.com'
      fill_in 'user_password', with: 'password'

      click_button 'create'

      expect(User.where(email: 'test@example.com').count).to eq 1
    end
  end
end
