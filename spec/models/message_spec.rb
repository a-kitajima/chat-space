require 'rails_helper'
describe Message do
  describe '#create' do
    it "is valid with message" do
      message = build(:message, image: nil)
      expect(message).to be_valid
    end

    it "is valid with image" do
      message = build(:message, body: nil)
      expect(message).to be_valid
    end

    it "is valid with message and image" do
      message = build(:message)
      expect(message).to be_valid
    end

    it "is invalid without message and image" do
      message = build(:message, body: nil, image: nil)
      message.valid?
      expect(message.errors[:body]).to include("を入力してください")
    end

    it "is invalid without group_id" do
      message = build(:message, group: nil)
      message.valid?
      expect(message.errors[:group]).to include("を入力してください")
    end

    it "is invalid without user_id" do
      message = build(:message, user: nil)
      message.valid?
      expect(message.errors[:user]).to include("を入力してください")
    end
  end
end