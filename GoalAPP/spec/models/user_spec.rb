require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    FactoryBot.build(:user, username: "jay@gmail.com", password: "password")
  end

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  describe "#is_password?" do
    it "matches correct password" do
      expect(user.is_password?("password")).to be true
    end

    it "verifies a password is not correct" do
      expect(user.is_password?("fkjlafslkdajslkfj")).to be false
    end
  end

  describe "#reset_session_token!" do
    it "sets a new session token on the user" do
      old_user_session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(old_user_session_token)
    end
  end

  describe "::find_by_credentials" do
    it "finds user" do
      user.save
      expect(User.find_by_credentials("jay@gmail.com", "password")).to eq(user)
    end
  end
end
