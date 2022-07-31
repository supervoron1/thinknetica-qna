require 'rails_helper'

feature 'User can create answer to the question', %q{
  In order to add answer to community
  As an authenticated user
  I'd like to be able to create answer to the question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit question_path(question)
    end

    scenario 'answers to question' do
      fill_in 'Body', with: 'answer answer!'
      click_on 'Submit answer'

      expect(page).to have_content 'answer answer!'
    end

    scenario 'answers to question with errors' do
      fill_in 'Body', with: ''
      click_on 'Submit answer'

      expect(page).to have_content "Body can't be blank"
    end
  end

  describe 'Unauthenticated user' do
    scenario 'tries to answer to question' do
      visit question_path(question)
      fill_in 'Body', with: 'unauthenticated user answer'
      click_on 'Submit answer'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end