require 'rails_helper'

RSpec.describe 'Users', type: :system do
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

      click_on "新規登録"
      fill_in "new_profile_name", with: "test_name"
      fill_in "new_user_email", with: "test@test"
      fill_in "new_user_password", with: "password"
      fill_in "new_user_password_confirmation", with: "passward"
      click_button "新規登録する"
      expect(page).to have_content "確認用パスワードとパスワードの入力が一致しません"
    end
    
    it "パスワードが正しく２回入力されていないとエラーになる" do
      visit root_path
      expect(page).to have_http_status :ok

      click_on "新規登録"
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

      click_on "新規登録"
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

      click_on "ログアウト"
      expect(page).to have_content 'Signed out successfully.'
    end
  end
end
