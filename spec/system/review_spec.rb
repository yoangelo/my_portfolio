require "rails_helper"

RSpec.describe "レビュー機能", js: true, type: :system do
  before do
    @user = FactoryBot.create(:user)
    @restaurant = FactoryBot.create(:restaurant)
    visit root_path
    find("li", text: "ログイン").click
    fill_in "login_user_email", with: "rspec_test@test.com"
    fill_in "login_user_password", with: "password"
    click_on "ログインする"
  end

  describe "レビュー投稿機能" do
    before do
      visit new_restaurant_review_path(restaurant_id: @restaurant.id)
    end

    context "表示確認" do
      it "投稿ページの表示" do
        expect(page).to have_content "test_restaurant"
        expect(page).to have_content "タグの入力"
      end
    end

    context "投稿確認" do
      it "投稿できること" do
        fill_in "review_title", with: "test_review_title"
        fill_in "review_body", with: "test_review_body"
        fill_in "review_tag_list", with: "テスト,タグ"
        expect {click_button "投稿"}.to change { Review.count }.by(1)
        expect(page).to have_content "作成できました"
      end
    end
  end

  describe "レビュー編集および削除機能" do
    before do
      @rev = FactoryBot.create(:review, restaurant_id: @restaurant.id, user_id: @user.id )
      visit restaurant_review_path(restaurant_id: @restaurant.id, id: @rev.id)
    end

    context "詳細確認" do
      it "詳細ページの表示" do
        expect(page).to have_content "TEST"
      end
    end

    context "編集確認" do
      before do
        click_on "編集する"
      end

      it "編集できること" do
        fill_in "review_title", with: "TEST_edit"
        fill_in "review_body", with: "test_body_edit"
        fill_in "review_tag_list", with: "テスト,タグ,へんしゅう"
        click_button "投稿"
        expect(page).to have_content "更新できました","TEST_edit"
        expect(page).to have_content "test_body_edit"
        expect(page).to have_content "へんしゅう"
      end
    end

    context "削除確認" do
      it "削除できること" do
        expect{
          page.accept_confirm { click_on "削除する" }
        }.to change { @user.review.count }.by(0)
        expect(page).to have_content "削除に成功しました"
      end
    end
  end
end
