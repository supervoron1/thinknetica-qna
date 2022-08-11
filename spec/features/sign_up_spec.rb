require 'rails_helper'

feature 'User can sign up', %q{
  In order to get answer from a community
  As an unauthenticated user
  I'd like to be able to sign up
} do

  describe 'Unregistered user' do
    background do
      visit new_user_registration_path
      fill_in 'Email', with: 'email@test.com'
    end

    scenario 'tries to sign up' do
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_on 'Sign up'

      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end

    scenario 'tries to sign up with errors' do
      fill_in 'Password', with: '12345'
      fill_in 'Password confirmation', with: '12345'
      click_on 'Sign up'

      expect(page).to have_content 'Password is too short (minimum is 6 characters)'
    end

    scenario 'tries to sign up with not matching passwords' do
      fill_in 'Password', with: '123456789'
      fill_in 'Password confirmation', with: '12345'
      click_on 'Sign up'

      expect(page).to have_content "Password confirmation doesn't match Password"
    end
  end

end