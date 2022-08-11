require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:questions).dependent(:destroy) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe "#author_of?" do
    let(:user) { create(:user) }

    it 'returns true if user is the author of object' do
      expect(user).to be_author_of(create(:question, user: user))
    end

    it 'returns false if user is not the author of object' do
      expect(user).not_to be_author_of(create(:question))
    end
  end
end
