require 'rails_helper'

RSpec.describe ReviewCategoryRelation, type: :model do
  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "Reviewモデルとのアソシエーション" do
      let(:target) { :review }

      it "Reviewとの関連付けはbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "Categoryモデルとのアソシエーション" do
      let(:target) { :category }

      it "Categoryとの関連付けはbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
