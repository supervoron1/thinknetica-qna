require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer) } }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question show view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer) }

        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      before { login(user) }

      it 'does not save the answer' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid) } }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid) }

        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }

    context "answer's author" do
      let!(:answer) { create(:answer, user: user) }
      it 'deletes the question' do
        expect { delete :destroy, params: { question_id: answer.question, id: answer } }.to change(Answer, :count).by(-1)
      end

      it 'redirects to index' do
        delete :destroy, params: { question_id: answer.question, id: answer }
        expect(response).to redirect_to question_path(answer.question)
      end
    end

    context "not answer's author" do
      let!(:answer) { create(:answer) }

      it "doesn't delete since it's not author's question" do
        answer.reload # todo: research why it's necessary
        expect { delete :destroy, params: { question_id: answer.question, id: answer } }.to_not change(Answer, :count)
      end

      it 'redirects to question' do
        delete :destroy, params: { question_id: answer.question, id: answer }
        expect(response).to redirect_to question_path(answer.question)
      end
    end
  end
end
