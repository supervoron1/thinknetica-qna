require 'rails_helper'

feature 'User can delete answer', %q{
  In order to delete incorrect answer
  As an authenticated user
  I'd like to be able to delete answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }

  # question/answer of another user
  given!(:alien_question) { create(:question) }
  given!(:alien_answer) { create(:answer, question: alien_question) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
    end

    scenario 'deletes his answer' do
      visit question_path(question)
      expect(page).to have_content 'Answer_body'
      click_on 'Delete answer'

      expect(page).to have_content 'Answer was successfully deleted'
      expect(page).to_not have_content 'Answer_body'
    end

    scenario "deletes not his answer" do
      visit question_path(alien_question)
      save_and_open_page

      expect(page).to have_no_link('Delete answer')
    end
  end

  describe 'Unauthenticated user' do
    scenario "tries to delete answer"
  end
end