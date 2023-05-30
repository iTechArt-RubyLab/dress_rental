require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }

  it 'is valid with valid attributes' do
    expect(comment).to be_valid
  end

  it 'is not valid without a user' do
    comment.user = nil
    expect(comment).not_to be_valid
  end

  it 'is not valid without a salon' do
    comment.salon = nil
    expect(comment).not_to be_valid
  end
end
