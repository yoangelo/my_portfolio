require "rails_helper"

RSpec.describe "Notifications", type: :system do
  let(:current_user) { FactoryBot.create(:user) }
  let(:other_user)   { FactoryBot.create(:user, email: "other_test@test.com", username: "other") }
  let(:current_rest) { FactoryBot.create(:restaurant) }
  let(:current_rev)  { FactoryBot.create(:review, restaurant_id: current_rest.id, user_id: current_user.id) }

  describe "ユーザーがログインしているとき", js: true do
    context "レビューに投稿者以外のユーザーがコメントといいねを行う" do
      before do
        login_test_user(other_user)
        visit restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
        find("i", id: "uniine_like").click
        fill_in "body", with: "テストコメントです"
        click_button "comment_btn"
        click_link "ログアウト"
      end

      it "通知ページにコメントといいねしたことが表示される" do
        login_test_user(current_user)
        visit notifications_path
        expect(page).to have_selector 'span', text: "otherさんが"
        expect(page).to have_selector 'a', text: "あなたの投稿"
        expect(page).to have_selector 'span', text: "にコメントしました"
        expect(page).to have_selector 'span', text: "にいいねしました"
      end
    end

    context "レビューに投稿者自身がコメントといいねを行う" do
      before do
        login_test_user(current_user)
        visit restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
        find("i", id: "uniine_like").click
        fill_in "body", with: "テストコメントです"
        click_button "comment_btn"
      end

      it "通知ページにコメントといいねしたことが表示されない" do
        visit notifications_path
        expect(page).to have_selector 'p', text: "通知はありません"
        expect(page).not_to have_selector 'span', text: "anonymousさんが"
        expect(page).not_to have_selector 'a', text: "あなたの投稿"
        expect(page).not_to have_selector 'span', text: "にコメントしました"
        expect(page).not_to have_selector 'span', text: "にいいねしました"
      end
    end
  end
end
