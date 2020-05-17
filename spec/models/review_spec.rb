require 'rails_helper'

RSpec.describe Review, type: :model do

  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:review)).to be_valid
  end

  context "reviewモデルのバリデーション" do

    it "タイトルがなければ無効な状態であること" do
      review = FactoryBot.build(:review, title: nil)
      review.valid?
      expect(review.errors[:title]).to include("を入力してください")
    end

    it "本文がなければ無効な状態であること" do
      review = FactoryBot.build(:review, body: nil)
      review.valid?
      expect(review.errors[:body]).to include("を入力してください")
    end

    it "タイトルが51文字以上であれば無効であること" do
      review = FactoryBot.build(:review, title: "a" * 51)
      review.valid?
      expect(review.errors[:title]).to include("は50文字以内で入力してください")
    end
  end

  describe "各モデルとのアソシエーション" do
    before do
      @rev  = FactoryBot.create(:review)
      ReviewImage.create(review_id: @rev.id)
      Like.create(review_id: @rev.id, user_id: @rev.user_id)
      Comment.create(review_id: @rev.id, user_id: @rev.user_id, body: "TEST")
    end
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "Userモデルとのアソシエーション" do
      let (:target) { :user }

      it "Profileとの関連付けはhas_oneであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "Restaurantモデルとのアソシエーション" do
      let (:target) { :restaurant }

      it "Profileとの関連付けはhas_oneであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "ReviewImageモデルとのアソシエーション" do
      let (:target) { :review_images }

      it "ReviewImageとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Reviewが削除されたらReviewImageも削除されること" do
        expect{ @rev.destroy }.to change { ReviewImage.count }.by(-1)
      end
    end

    context "Likeモデルとのアソシエーション" do
      let (:target) { :likes }

      it "Likeとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Reviewが削除されたらReviewImageも削除されること" do
        expect{ @rev.destroy }.to change { Like.count }.by(-1)
      end
    end

    context "Commentモデルとのアソシエーション" do
      let (:target) { :comments }

      it "Commentとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Reviewが削除されたらCommentも削除されること" do
        expect{ @rev.destroy }.to change { Comment.count }.by(-1)
      end
    end

    context "Notificationモデルとのアソシエーション" do
      let (:target) { :notifications }

      it "Notificationとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end
  end
end
