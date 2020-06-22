require 'rails_helper'

RSpec.describe 'Profile', type: :system do
  let(:current_user) { FactoryBot.create(:user, email: "current_test@test.com", username: "テスト二郎") }
  let(:other_user) { FactoryBot.create(:user, email: "other_test@test.com", username: "テスト子") }
  let!(:current_profile) { FactoryBot.create(:profile, name: current_user.username, user_id: current_user.id) }
  let!(:other_profile) { FactoryBot.create(:profile, name: other_user.username, user_id: other_user.id) }

  describe "ユーザーが新規登録した場合" do
    before "ユーザーの新規登録" do
      visit root_path
      click_button "新規登録"
      fill_in "new_profile_name", with: "test_name"
      fill_in "new_user_email", with: "test@test"
      fill_in "new_user_password", with: "password"
      fill_in "new_user_password_confirmation", with: "password"
      click_button "新規登録する"
      @user = User.last
      @profile = Profile.last
    end

    it "紐づいたProfileモデルが作成される" do
      expect(@user.id).to eq @profile.user_id
      expect(@profile.user.username).to eq "test_name"
      expect(@user.profile.name).to eq "test_name"
    end
  end

  describe "ユーザーがログインしているとき" do
    let(:login_user) { current_user }

    before do
      login_test_user(login_user)
    end

    context "現在のユーザー=プロフィール画面のユーザーの場合" do
      before do
        visit profile_path(id: current_profile.id)
      end

      it "プロフィール画面が表示される" do
        expect(page).to have_selector "img"
        expect(page).to have_selector "span", text: "テスト二郎"
        expect(page).to have_selector "span", text: "25~29歳"
        expect(page).to have_selector "span", text: "和歌山県"
        expect(page).to have_selector "span", text: "1人"
        expect(page).to have_selector "p", text: "よろしくお願いします"
      end

      it "編集画面にアクセスでき、プロフィールを編集できる" do
        click_on "編集する"
        expect(current_path).to eq edit_profile_path(id: current_profile.id)
        attach_file "edit_avatar", "spec/files/test_image1.jpg"
        fill_in "edit_name", with: "テスト太郎"
        select "30~34歳", from: "profile_age"
        select "東京都", from: "profile_liveplace"
        select "2人", from: "profile_children"
        fill_in "edit_introduce", with: "こんにちはみなさん"
        click_on "更新"
        expect(current_path).to eq profile_path(id: current_profile.id)
        expect(page).to have_selector "img[src$='test_image1.jpg']"
        expect(page).to have_selector "span", text: "テスト太郎"
        expect(page).to have_selector "span", text: "30~34歳"
        expect(page).to have_selector "span", text: "東京都"
        expect(page).to have_selector "span", text: "2人"
        expect(page).to have_selector "p", text: "こんにちはみなさん"
      end
    end

    context "現在のユーザー≠プロフィール画面のユーザーの場合" do
      before do
        visit profile_path(id: other_profile.id)
      end

      it "プロフィール画面が表示されるが、編集できないこと" do
        expect(page).to have_selector "img"
        expect(page).to have_selector "span", text: "テスト子"
        expect(page).to have_selector "span", text: "25~29歳"
        expect(page).to have_selector "span", text: "和歌山県"
        expect(page).to have_selector "span", text: "1人"
        expect(page).to have_selector "p", text: "よろしくお願いします"
        expect(page).not_to have_selector 'a', text: "編集する"
        visit edit_profile_path(id: other_profile.id)
        expect(current_path).to eq profile_path(id: other_profile.id)
        expect(page).to have_content "無効なURLです"
      end
    end
  end

  describe "ユーザーがログインしていないとき" do
    before do
      visit profile_path(id: other_profile.id)
    end

    it "プロフィール画面が表示されるが、編集できないこと" do
      expect(page).to have_selector "img"
      expect(page).to have_selector "span", text: "テスト子"
      expect(page).to have_selector "span", text: "25~29歳"
      expect(page).to have_selector "span", text: "和歌山県"
      expect(page).to have_selector "span", text: "1人"
      expect(page).to have_selector "p", text: "よろしくお願いします"
      expect(page).not_to have_selector 'a', text: "編集する"
      visit edit_profile_path(id: other_profile.id)
      expect(current_path).to eq profile_path(id: other_profile.id)
      expect(page).to have_content "無効なURLです"
    end
  end
end
