require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.create(:user) }
  
  let(:user) { FactoryBot.create(:user) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_length_of(:password).is_at_least(8) }
  it { should allow_value("+375291234567").for(:phone) }
  it { should_not allow_value("291234567").for(:phone) }
  it { should_not allow_value("+37529987654321").for(:phone) }
  it { should_not allow_value("+333").for(:phone) }
  it { should_not allow_value(nil).for(:phone) }
  it { should allow_value(nil).for(:avatar) }

  it { should have_many(:rentals).dependent(:destroy) }
  it { should have_many(:products).through(:rentals) }
  it { should have_many(:comments) }
  it { should have_one_attached(:avatar) }
  it { should have_many(:salons).class_name('Salon').with_foreign_key('owner_id').dependent(:destroy) }

  describe "#username" do
    it "returns the full name of the user" do
      expect(user.username).to eq("#{user.first_name} #{user.last_name}")
    end
  end

  describe ".from_omniauth" do
    let(:auth) { OmniAuth::AuthHash.new(provider: 'google_oauth2', uid: '123', info: { email: 'newuser@example.com'}) }

    context "when user already exists" do
      it "returns the user" do
        existing_user = FactoryBot.create(:user, provider: auth.provider, uid: auth.uid)
        expect(User.from_omniauth(auth)).to eq(existing_user)
      end
    end

    context "when user does not exist" do
      it "creates a new user" do
        expect { User.from_omniauth(auth) }.to change(User, :count).by(1)
      end
    end
  end

  describe "#update_user_rating" do
    let(:salon) { FactoryBot.create(:salon, owner_id: user.id) }
    let!(:rental) { FactoryBot.create(:rental, user_id: user.id, product_id: salon.id, salon_rating: 3) }

    before do
      user.update_user_rating
    end

    it "updates user rating with the average salon rating for rentals rated by salon owners" do
      expect(user.rating).to eq(3)
    end
  end

  describe "#avatar_url" do
    context "when user has attached an avatar" do
      before do
        file = fixture_file_upload(Rails.root.join('spec', 'support', 'default-avatar.png'), 'image/png')
        user.avatar.attach(file)
      end

      it "returns the user's attached avatar" do
        expect(user.avatar_url).to eq(user.avatar)
      end
    end

    context "when user has not attached an avatar" do
      it "returns the default avatar url" do
        expect(user.avatar_url).to eq(User::DEFAULT_AVATAR_URL)
      end
    end
  end
end