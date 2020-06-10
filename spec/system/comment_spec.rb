require "rails_helper"

RSpec.describe "Comments", type: :system do
  let(:current_user) { FactoryBot.create(:user) }
  let!(:current_profile) { FactoryBot.create(:profile, name: current_user.username, user_id: current_user.id) }
  let(:other_user) { FactoryBot.create(:user, email: "other_test@test.com", username: "other") }
  let!(:other_profile) { FactoryBot.create(:profile, name: other_user.username, user_id: other_user.id) }
  let(:current_rest) { FactoryBot.create(:restaurant) }
  let(:current_rev)  { FactoryBot.create(:review, restaurant_id: current_rest.id, user_id: current_user.id) }
  let(:current_com)  { FactoryBot.create(:comment, review_id: current_rev.id, user_id: current_user.id) }

  describe "ユーザーがログインしているとき" do
    before do
      login_test_user(login_user)
      current_com
      visit restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
    end

    describe "現在のユーザー=コメントユーザー" do
      let(:login_user) { current_user }

      it "コメント欄が表示されていること" do
        expect(page).to have_selector "textarea", id: "body"
      end

      it "コメントができること", js: true do
        fill_in "body", with: "テストコメントです"
        click_button "comment_btn"
        expect(page).to have_content "テストコメントです"
        expect(Comment.count).to eq 2
      end

      it "削除できること", js: true do
        page.accept_confirm "このコメントを削除しますか？" do
          click_on "コメントを削除する"
        end
        expect(page).not_to have_content "Test_body"
        expect(Comment.count).to eq 0
      end
    end

    describe "現在のユーザー≠コメントユーザー" do
      let(:login_user) { other_user }

      it "削除することができないこと" do
        expect(page).to have_selector "a", text: "anonymousさん"
        expect(page).to have_selector "textarea", id: "body"
        expect(page).not_to have_content "コメントを削除する"
      end
    end
  end

  describe "ユーザーがログインしていないとき" do
    it "コメント入力欄が表示されないこと" do
      visit restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
      expect(page).not_to have_selector "textarea", id: "body"
      expect(page).not_to have_selector "input", id: "comment_btn"
    end
  end
end
