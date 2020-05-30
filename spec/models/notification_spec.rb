require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:association) do
    described_class.reflect_on_association(target)
  end

  context "Reviewモデルとのアソシエーション" do
    let(:target) { :review }

    it "Reviewとの関連付けはbelongs_toであること" do
      expect(association.macro).to eq :belongs_to
    end
  end

  context "Commentモデルとのアソシエーション" do
    let(:target) { :comment }

    it "Reviewとの関連付けはbelongs_toであること" do
      expect(association.macro).to eq :belongs_to
    end
  end

  context "visitorとのアソシエーション" do
    let(:target) { :visitor }

    it "Reviewとの関連付けはbelongs_toであること" do
      expect(association.macro).to eq :belongs_to
    end
  end

  context "visitedとのアソシエーション" do
    let(:target) { :visited }

    it "Reviewとの関連付けはbelongs_toであること" do
      expect(association.macro).to eq :belongs_to
    end
  end
end
