require "rails_helper"

RSpec.describe "Notifications", type: :system do
  let!(:current_user) { FactoryBot.create(:user) }
  let!(:other_user)   { FactoryBot.create(:user, email: "other_test@test.com", username: "other") }
  let!(:current_profile) { FactoryBot.create(:profile, name: current_user.username, user_id: current_user.id) }
  let!(:other_profile) { FactoryBot.create(:profile, name: other_user.username, user_id: other_user.id) }
  let(:current_rest) { FactoryBot.create(:restaurant) }
  let(:current_rev)  { FactoryBot.create(:review, restaurant_id: current_rest.id, user_id: current_user.id) }

  describe "ユーザーがログインしているとき", js: true do
    context "レビューに投稿者以外のユーザーがコメントといいねを行う" do
      before do
        login_test_user(other_user)
        visit restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
        find("i", id: "uniine_like").click
        fill_in "body", with: "テストコメントです"
        click_button id: "btn-comment"
        click_on id: "navbarDropdown"
        click_on id: "log_out"
      end

      it "通知ページにコメントといいねしたことが表示される" do
        login_test_user(current_user)
        visit notifications_path
        expect(page).to have_content "other"
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
        click_button id: "btn-comment"
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
