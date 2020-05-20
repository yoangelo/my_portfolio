require 'rails_helper'

RSpec.describe User, type: :model do

  it "有効なファクトリを持つこと" do
    expect(FactoryBot.create(:user)).to be_valid
  end

  context "Userモデルのバリデーション" do

    it "メールアドレスがなければ無効な状態であること" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("が入力されていません。")
    end

    it "名前(ニックネーム)がなければ無効な状態であること" do
      user = FactoryBot.build(:user, username: nil)
      user.valid?
      expect(user.errors[:username]).to include("を入力してください")
    end

    it "パスワードがなければ無効な状態であること" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("が入力されていません。")
    end

    it "重複したメールアドレスなら無効な状態であること" do
      FactoryBot.create(:user)
      user2 = FactoryBot.build(:user, email: "test@test")
      user2.valid?
      expect(user2.errors[:email]).to include("は既に使用されています。")
    end
  end


  describe "各モデルとのアソシエーション" do
    before do
      @user = FactoryBot.create(:user)
      rest = Restaurant.create(name: "test_restaurant", address: "1-1-1", res_id: "1111111")
      prof = Profile.create(user_id: @user.id, name: "TEST")
      rev  = Review.create(user_id: @user.id, restaurant_id: rest.id, title: "Test_Title", body: "test_body")
      Like.create(review_id: rev.id, user_id: @user.id)
      Comment.create(review_id: rev.id, user_id: @user.id, body: "TEST")
    end
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "Profileモデルとのアソシエーション" do
      let (:target) { :profile }

      it "Profileとの関連付けはhas_oneであること" do
        expect(association.macro).to eq :has_one
      end

      it "Userが削除されたらProfileも削除されること" do
        expect{ @user.destroy }.to change { Profile.count }.by(-1)
      end
    end

    context "Reviewモデルとのアソシエーション" do
      let (:target) { :review }

      it "Reviewとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Userが削除されたらReviewも削除されること" do
        expect{ @user.destroy }.to change { Review.count }.by(-1)
      end
    end

    context "Likeモデルとのアソシエーション" do
      let (:target) { :likes }

      it "Likeとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Userが削除されたらLikeも削除されること" do
        expect{ @user.destroy }.to change { Like.count }.by(-1)
      end
    end

    context "Commentモデルとのアソシエーション" do
      let (:target) { :comments }

      it "Commentとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Userが削除されたらCommentも削除されること" do
        expect{ @user.destroy }.to change { Comment.count }.by(-1)
      end
    end

    context "active_notificationsとのアソシエーション" do
      let (:target) { :active_notifications }

      it "Reviewとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end

    context "passive_notificationsとのアソシエーション" do
      let (:target) { :passive_notifications }

      it "Reviewとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end
  end
end
