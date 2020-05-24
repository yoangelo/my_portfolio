require "rails_helper"

RSpec.describe "Comments", type: :system do
  let (:current_user) { FactoryBot.create(:user) }
  let (:current_rest) { FactoryBot.create(:restaurant) }
  let (:current_rev)  { FactoryBot.create(:review, restaurant_id: current_rest.id, user_id: current_user.id ) }

  describe "ユーザーがログインしているとき" do
    let (:login_user) { current_user }
    before do
      visit root_path
      find("li", text: "ログイン").click
      fill_in "login_user_email", with: login_user.email
      fill_in "login_user_password", with: login_user.password
      click_on "ログインする"
      visit restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
    end

    it "コメント欄が表示されていること" do
      expect(page).to have_selector "textarea", id: "body"
      expect(page).to have_selector "input", id: "comment_btn"
    end

    it "コメントすることができ、その後削除することができること", js: true do
      fill_in "body", with: "コメントを入力します"
      click_button "comment_btn"
      expect(page).to have_content "コメントを入力します"
      expect(Comment.count).to eq 1
      click_on "コメントを削除する"
      expect(page).to_not have_content "コメントを入力します"
      expect(Comment.count).to eq 0
    end
  end

  describe "ユーザーがログインしていないとき" do
    before do
      visit restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
    end
    
    it "コメント欄が表示されないこと" do
      expect(page).to_not have_selector "textarea", id: "body"
      expect(page).to_not have_selector "input", id: "comment_btn"
    end
  end
end
