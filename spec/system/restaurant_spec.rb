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

      it "javascriptが効いている" do
        take_screenshot
        within first("ul", id: "rest_lists") do
          expect(page).to have_selector 'li', text: "うふふ"
        end
        # within first("li", id: "rest_list") do
        #   find("input").choose
        # end
        # click_button "登録する"
        # expect(page).to have_selector 'h1', text: "口コミを投稿する"
      end

      it "クリックが効いている" do
        fill_in "name", with: "マクドナルド"
        find("input", id: "rest_search").click
        puts page.html
        within first("ul", id: "rest_lists") do
          expect(page).to have_selector 'li', text: "わわわわー"
        end
        take_screenshot
        # within first("li", id: "rest_list") do
        #   find("input").choose
        # end
        # click_button "登録する"
        # expect(page).to have_selector 'h1', text: "口コミを投稿する"
      end

      it "APIが効いている" do
        fill_in "name", with: "マクドナルド"
        find("input", id: "rest_search").click
        puts page.html
        within first("ul", id: "rest_lists") do
          expect(page).to have_selector 'li', text: "マクドナルド"
        end
        within first("li", id: "rest_list") do
          find("input").choose
        end
        click_button "登録する"
        expect(page).to have_selector 'h1', text: "口コミを投稿する"
      end

      it "文字を入力しなおすと、一覧表示された店がクリアされること" do
        fill_in "name", with: "マクドナルド"
        find("input", id: "rest_search").click
        page.html
        within first("ul", id: "rest_lists") do
          expect(page).to have_selector 'li', text: "マクドナルド"
        end
        fill_in "name", with: ""
        expect(page).not_to have_selector 'li', text: "マクドナルド"
      end
    end
  end

  describe "ユーザーがログインしていないとき", js: true do
    before do
      visit root_path
      click_on "投稿する"
    end
    it "レストラン検索ページが表示されずログインページにリダイレクトすること" do
      expect(page).not_to have_selector 'h1', text: "お店を検索する"
      expect(page).to have_content "ログインしてください"
      expect(page).to have_selector 'h1', text: 'ログイン'
    end
  end
end
