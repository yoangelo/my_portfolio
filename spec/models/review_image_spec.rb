require 'rails_helper'

RSpec.describe ReviewImage, type: :model do
  let(:association) do
    described_class.reflect_on_association(target)
  end

  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:review_image)).to be_valid
  end

  context "Reviewモデルとのアソシエーション" do
    let (:target) { :review }

    it "Reviewとの関連付けはbelongs_toであること" do
      expect(association.macro).to eq :belongs_to
    end
  end
end
