require "rails_helper"

RSpec.describe "Notifications", type: :system do
  let (:current_user) { FactoryBot.create(:user) }
  let (:other_user)   { FactoryBot.create(:user, email: "other_test@test.com", username: "other") }
  let (:current_rest) { FactoryBot.create(:restaurant) }
  # 呼びだし時に投稿作成
  let (:current_rev)  { FactoryBot.create(:review, restaurant_id: current_rest.id, user_id: current_user.id ) }

  describe "ユーザーがログインしているとき", js: true do
    context "レビューに投稿者以外のユーザーがコメントといいねを行う" do
      before do
        # 他のユーザーでログイン
        visit root_path
        find("li", text: "ログイン").click
        sleep 2
        fill_in "login_user_email", with: other_user.email
        fill_in "login_user_password", with: other_user.password
        click_on "ログインする"
        # 他のユーザーでコメントおよびいいね
        visit restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
        find("i", id: "uniine_like").click
        fill_in "body", with: "テストコメントです"
        click_button "comment_btn"
        click_link "ログアウト"
      end
      it "通知ページにコメントといいねしたことが表示される" do
        visit root_path
        find("li", text: "ログイン").click
        sleep 2
        fill_in "login_user_email", with: current_user.email
        fill_in "login_user_password", with: current_user.password
        click_on "ログインする"
        visit notifications_path
        expect(page).to have_selector 'span', text: "otherさんが"
        expect(page).to have_selector 'a', text: "あなたの投稿"
        expect(page).to have_selector 'span', text: "にコメントしました"
        expect(page).to have_selector 'span', text: "にいいねしました"
      end
    end
    context "レビューに投稿者自身がコメントといいねを行う" do
      before do
        # 投稿ユーザーでログイン
        visit root_path
        find("li", text: "ログイン").click
        sleep 2
        fill_in "login_user_email", with: current_user.email
        fill_in "login_user_password", with: current_user.password
        click_on "ログインする"
        # 投稿ユーザーでコメントおよびいいね
        visit restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
        find("i", id: "uniine_like").click
        fill_in "body", with: "テストコメントです"
        click_button "comment_btn"
      end
      it "通知ページにコメントといいねしたことが表示されない" do
        visit notifications_path
        expect(page).to have_selector 'p', text: "通知はありません"
        expect(page).to_not have_selector 'span', text: "anonymousさんが"
        expect(page).to_not have_selector 'a', text: "あなたの投稿"
        expect(page).to_not have_selector 'span', text: "にコメントしました"
        expect(page).to_not have_selector 'span', text: "にいいねしました"
      end
    end
  end
end
