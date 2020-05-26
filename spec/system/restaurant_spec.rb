require "rails_helper"

RSpec.describe "Restaurants", type: :system do
  let (:current_user) { FactoryBot.create(:user) }
  describe "ユーザーがログインしているとき" do
    before do
      login_test_user(login_user)
    end

    describe "レストラン検索",js: true do
      let (:login_user) { current_user }
      before do
        click_on "投稿する"
      end
      it "レストラン検索ページが表示されること" do
        expect(page).to have_selector 'h1', text: "お店を検索する"
        expect(page).to have_selector 'input', id: "rest_search"
      end
      # it "検索したキーワードと一致した店が一覧表示されること" do
      #   fill_in "name", with: "マクドナルド"
      #   find("input", id: "rest_search").click
      #   sleep 3
      #   expect(page).to have_selector 'li', text: "マクドナルド"
      # end
      # it "選択した店の新規レビュー投稿ページに遷移すること" do
      #
      # end
    end
  end

  # describe "ユーザーがログインしていないとき" do
  #   it "レストラン検索ページが表示されずログインページにリダイレクトすること" do
  #
  #   end
  # end
end
