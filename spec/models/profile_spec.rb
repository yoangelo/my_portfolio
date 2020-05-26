require 'rails_helper'

RSpec.describe Profile, type: :model do
  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:profile)).to be_valid
  end

  context "Profileモデルのバリデーション" do

    it "名前がなければ無効な状態であること" do
      profile = FactoryBot.build(:profile, name: nil)
      profile.valid?
      expect(profile.errors[:name]).to include("を入力してください")
    end
  end
  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    context "Userモデルとのアソシエーション" do
      let (:target) { :user }

      it "Userとの関連付けはbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
