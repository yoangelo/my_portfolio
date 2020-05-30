require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:comment)).to be_valid
  end

  context "commentモデルのバリデーション" do
    it "本文がなければ無効な状態であること" do
      comment = FactoryBot.build(:comment, body: nil)
      comment.valid?
      expect(comment.errors[:body]).to include("を入力してください")
    end

    it "本文が201文字以上であれば無効な状態であること" do
      comment = FactoryBot.build(:comment, body: "a" * 201)
      comment.valid?
      expect(comment.errors[:body]).to include("は200文字以内で入力してください")
    end
  end

  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "Userモデルとのアソシエーション" do
      let(:target) { :user }

      it "Profileとの関連付けはbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "Reviewモデルとのアソシエーション" do
      let(:target) { :review }

      it "Reviewとの関連付けはbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "Notificationモデルとのアソシエーション" do
      let(:target) { :notifications }

      it "Notificationとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end
  end
end
