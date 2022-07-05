require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe 'GET #index' do
    let!(:questions) { create_list(:question, 3) } # bang(!) to initialize before each test

    before { get :index }

    it 'populates an array of all questions' do
      # questions = create_list(:question, 3)

      # get :index # moved to before action

      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      # get :index
      expect(response).to render_template :index
    end
  end

end
