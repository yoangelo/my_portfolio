require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:current_user) { FactoryBot.create(:user, email: "user_test@test.com") }
  let!(:current_profile) { FactoryBot.create(:profile, name: current_user.username, user_id: current_user.id) }

  describe '新規登録機能' do
    before do
      ActionMailer::Base.deliveries.clear
    end

    def extract_confirmation_url(mail)
      body = mail.body.encoded
      body[/http[^"]+/]
    end

    it "パスワードが正しく２回入力されていないとエラーになる" do
      visit root_path
      expect(page).to have_http_status :ok

      click_button "新規登録"
      fill_in "new_profile_name", with: "test_name"
      fill_in "new_user_email", with: "test@test"
      fill_in "new_user_password", with: "password"
      fill_in "new_user_password_confirmation", with: "passward"
      click_button "新規登録する"
      expect(page).to have_content "確認用パスワードとパスワードの入力が一致しません"
    end

    it "ユーザー登録後、ログアウトとログインが正しく行われる" do
      visit root_path
      expect(page).to have_http_status :ok

      click_button "新規登録"
      fill_in "new_profile_name", with: "test_name"
      fill_in "new_user_email", with: "test@test"
      fill_in "new_user_password", with: "password"
      fill_in "new_user_password_confirmation", with: "password"
      expect { click_button "新規登録する" }.to change { ActionMailer::Base.deliveries.size }.by(1)
      expect(page).to have_content "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"

      mail = ActionMailer::Base.deliveries.last
      url = extract_confirmation_url(mail)
      visit url
      expect(page).to have_content "メールアドレスが確認できました。"

      click_link "ログアウト"
      expect(page).to have_content 'ログアウトしました。'

      click_button "ログイン"
      fill_in "login_user_email", with: "test@test"
      fill_in "login_user_password", with: "password"
      click_on "ログインする"
      expect(page).to have_content "ログインしました。"
    end
  end

  describe "Twitterでのログインができること", js: true do
    before do
      OmniAuth.config.test_mode = true
      FactoryBot.create(:user)
      OmniAuth.config.mock_auth[:twitter] = {
        "uid" => "123",
        "provider" => "twitter",
        "info" => { "nickname" => "anonymous" },
      }
      visit user_twitter_omniauth_authorize_path
    end

    it "ログインできること" do
      expect(page).to have_content "口コミを投稿する"
    end
  end
end
