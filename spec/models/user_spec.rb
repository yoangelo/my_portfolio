require 'rails_helper'

RSpec.describe User, type: :model do
  it "Eメールアドレス、パスワードがあれば有効な状態であること" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "メールアドレスがなければ無効な状態であること" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("が入力されていません。")
  end

  it "重複したメールアドレスなら無効な状態であること" do
    FactoryBot.create(:user, email: "aaron@example.com")
    user = FactoryBot.build(:user, email: "aaron@example.com")
    user.valid?
    expect(user.errors[:email]).to include("は既に使用されています。")
  end

  it "ユーザー一人につき一つのプロフィールを持ち、ユーザーが削除されたら同時に削除されること" do
    is_expected.to have_one(:profile).dependent(:destroy)
  end

  it "ユーザーは多数のレビューを持ち、ユーザーが削除されたら同時に削除されること"
  it "ユーザーは多数のいいねを持ち、ユーザーが削除されたら同時に削除されること"
  it "ユーザーは多数のコメントを持ち、ユーザーが削除されたら同時に削除されること"
  it "ユーザーは多数の通知発信を持ち、ユーザーが削除されたら同時に削除されること"
  it "ユーザーは多数の通知受信を持ち、ユーザーが削除されたら同時に削除されること"
  it "Twitter認証時、uidとproviderとusernameのレコードを作成すること"
  it "Twitterでの認証後サインアップするとユーザー登録され、以降はTwitter認証だけでログインできること"
end
