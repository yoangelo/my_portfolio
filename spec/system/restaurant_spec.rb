require "rails_helper"

RSpec.describe "Restaurants", type: :system do
  let!(:current_user) { FactoryBot.create(:user) }
  let!(:current_profile) { FactoryBot.create(:profile, name: current_user.username, user_id: current_user.id) }
  let!(:other_user)   { FactoryBot.create(:user, email: "other_test@test.com") }
  let!(:other_profile) { FactoryBot.create(:profile, name: other_user.username, user_id: other_user.id) }

  describe "レストラン検索機能" do
    describe "ユーザーがログインしているとき", js: true do
      before do
        login_test_user(current_user)
        click_on "投稿する"
      end

      it "レストラン検索ページが表示されること" do
        expect(page).to have_selector 'h1', text: "お店を検索する"
        expect(page).to have_selector 'input', id: "rest_search"
      end

      it "検索したキーワードと一致した店が一覧表示され、投稿ページにアクセスできること" do
        fill_in "name", with: "マクドナルド"
        find("input", id: "rest_search").click
        within first("ul", id: "rest_lists") do
          expect(page).to have_selector 'li', text: "マクドナルド"
          expect(page).to have_css 'img'
        end
        within first("li", id: "rest_list") do
          find("input").choose
        end
        click_button "登録する"
        within ".rev-card" do
          expect(page).to have_content "口コミを投稿する"
        end
      end

      it "文字を入力しなおすと、一覧表示された店がクリアされること" do
        fill_in "name", with: "マクドナルド"
        find("input", id: "rest_search").click
        within first("ul", id: "rest_lists") do
          expect(page).to have_selector 'li', text: "マクドナルド"
        end
        fill_in "name", with: ""
        expect(page).not_to have_selector 'li', text: "マクドナルド"
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

  describe "一覧表示の確認", js: true do
    before do
      create_list(:some_restaurant, 5)
      visit restaurants_path
    end

    it "レストラン一覧が表示され、レストラン名をクリックすると詳細ページにアクセスすること" do
      expect(page).to have_content "レストランその1"
      expect(page).to have_content "レストランその2"
      expect(page).to have_content "レストランその5"
      click_link "レストランその1"
      expect(current_path).to eq restaurant_path(id: 1)
    end
  end

  describe "詳細表示の確認", js: true do
    let(:test_rest) { FactoryBot.create(:restaurant, name: "aaa") }
    let!(:test_rest_rev_1) do
      FactoryBot.create(:review, restaurant_id: test_rest.id, user_id: current_user.id, title: "口コミその1")
    end
    let!(:test_rest_rev_2) do
      FactoryBot.create(:review, restaurant_id: test_rest.id, user_id: other_user.id, title: "口コミその2")
    end

    before do
      visit restaurant_path(id: test_rest.id)
    end

    it "口コミ一覧が表示され、タイトルをクリックすると口コミの詳細ページにアクセスすること" do
      expect(page).to have_css 'img'
      expect(page).to have_content "口コミその1"
      expect(page).to have_content "口コミその2"
      click_link "口コミその1"
      expect(current_path).to eq restaurant_review_path(restaurant_id: test_rest.id, id: test_rest_rev_1.id)
    end
  end
end
