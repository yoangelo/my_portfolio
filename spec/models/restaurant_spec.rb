require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:restaurant)).to be_valid
  end

  context "Restaurantモデルのバリデーション" do

    it "店名がなければ無効な状態であること" do
      rest = FactoryBot.build(:restaurant, name: nil)
      rest.valid?
      expect(rest.errors[:name]).to include("を入力してください")
    end

    it "住所がなければ無効な状態であること" do
      rest = FactoryBot.build(:restaurant, address: nil)
      rest.valid?
      expect(rest.errors[:address]).to include("を入力してください")
    end

    it "重複したres_idなら無効な状態であること" do
      FactoryBot.create(:restaurant)
      rest2 = FactoryBot.build(:restaurant, res_id: "0000000")
      rest2.valid?
      expect(rest2.errors[:res_id]).to include("はすでに存在します")
    end
  end

  describe "各モデルとのアソシエーション" do
    before do
      @rest = FactoryBot.create(:restaurant)
      user = User.create(email: "test@test", password: "password")
      rev  = Review.create(user_id: user.id, restaurant_id: @rest.id, title: "Test_Title", body: "test_body")
    end
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "Reviewモデルとのアソシエーション" do
      let (:target) { :reviews }

      it "Reviewとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Restaurantが削除されたらReviewも削除されること" do
        expect{ @rest.destroy }.to change { Restaurant.count }.by(-1)
      end
    end
  end
end
