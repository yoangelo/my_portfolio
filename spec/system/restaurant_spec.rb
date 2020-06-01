require "rails_helper"

RSpec.describe "Restaurants", type: :system do
  let(:current_user) { FactoryBot.create(:user) }

  describe "ユーザーがログインしているとき" do
    before do
      login_test_user(login_user)
    end

    describe "レストラン検索", js: true do
      let(:login_user) { current_user }

      before do
        click_on "投稿する"
      end

      it "レストラン検索ページが表示されること" do
        expect(page).to have_selector 'h1', text: "お店を検索する"
        expect(page).to have_selector 'input', id: "rest_search"
      end

      it "検索したキーワードと一致した店が一覧表示され、投稿ページにアクセスできること" do
        fill_in "name", with: "マクドナルド"
        find("input", id: "rest_search").click
        expect(page).to have_selector 'li', text: "マクドナルド"
        within first("li", id: "rest_list") do
          find("input").choose
        end
        expect { click_button "登録する" }.to change(Restaurant, :count).by(1)
        expect(page).to have_selector 'h1', text: "口コミを投稿する"
      end

      it "文字を入力しなおすと、一覧表示された店がクリアされること" do
        fill_in "name", with: "マクドナルド"
        find("input", id: "rest_search").click
        expect(page).to have_selector 'li', text: "マクドナルド"
        fill_in "name", with: ""
        expect(page).not_to have_selector 'li', text: "マクドナルド"
      end
    end
  end
end
