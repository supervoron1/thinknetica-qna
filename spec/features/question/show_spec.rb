require 'rails_helper'

feature 'User can see questions', %q{
  In order to get answer from a community
  As an (un)authenticated user
  I'd like to be able to see questions page
} do

  describe 'Without questions' do
    scenario 'user sees message about no questions' do
      visit questions_path

      expect(page).to have_content 'No questions yet.'
    end
  end

  describe 'With questions' do
    given(:user) { create(:user) }
    given!(:questions) { create_list(:question, 3) }

    scenario 'authenticated user sees questions' do
      sign_in(user)
      visit questions_path

      expect(page).to have_content(questions.first.title, count: 3)
    end

    scenario 'unauthenticated user sees questions' do
      visit questions_path

      expect(page).to have_content(questions.first.title, count: 3)
    end
  end
end