require 'rails_helper'

RSpec.describe Category, type: :model do
  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:category)).to be_valid
    expect(FactoryBot.build(:some_category)).to be_valid
  end
  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "Review_category_relationモデルとのアソシエーション" do
      let(:target) { :review_category_relations }

      it "Review_category_relationとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end
  end
end
