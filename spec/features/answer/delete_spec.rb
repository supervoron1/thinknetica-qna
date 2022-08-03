require 'rails_helper'

feature 'User can delete answer', %q{
  In order to delete incorrect answer
  As an authenticated user
  I'd like to be able to delete answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
    end

    scenario 'deletes his answer' do
      visit question_path(question)
      expect(page).to have_content 'Answer_body'
      # save_and_open_page
      click_on 'Delete answer'

      expect(page).to have_content 'Answer was successfully deleted'
      expect(page).to_not have_content 'Answer_Body'
    end

    scenario "deletes not his answer"
  end

  describe 'Unauthenticated user' do
    scenario "tries to delete answer"
  end
end