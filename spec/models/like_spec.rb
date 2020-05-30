require 'rails_helper'

RSpec.describe Like, type: :model do
  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build_stubbed(:like)).to be_valid
  end

  context "likeモデルのバリデーション" do
    it "user_idがなければ無効な状態であること" do
      like = FactoryBot.build(:like, user_id: nil)
      like.valid?
      expect(like.errors[:user_id]).to include("を入力してください")
    end

    it "review_idがなければ無効な状態であること" do
      like = FactoryBot.build(:like, review_id: nil)
      like.valid?
      expect(like.errors[:review_id]).to include("を入力してください")
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

      it "Profileとの関連付けはbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
