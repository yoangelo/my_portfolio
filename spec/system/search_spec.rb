require "rails_helper"

RSpec.describe "Searchs", type: :system do
  let(:current_user) { FactoryBot.create(:user) }
  let!(:current_profile) { FactoryBot.create(:profile, name: current_user.username, user_id: current_user.id) }
  let(:current_rest) { FactoryBot.create(:restaurant) }

  describe "検索機能" do
    before do
      FactoryBot.create(:search_a, restaurant_id: current_rest.id, user_id: current_user.id)
      FactoryBot.create(:search_b, restaurant_id: current_rest.id, user_id: current_user.id)
      visit reviews_index_path
      find("#icon-link").click
    end

    it "検索したキーワード「hoge」が本文中に含まれる記事が一覧表示される" do
      fill_in "search", with: "piyo"
      click_button "検索"
      expect(page).not_to have_content "foo"
      expect(page).to have_content "hoge"
      click_on "続きを見る"
      expect(page).to have_content "piyo"
    end
    it "検索フォームが空だと、リダイレクトされる" do
      click_button "検索"
      expect(page).to have_content "検索したい本文のキーワードを入力してください"
      expect(current_path).to eq reviews_index_path
    end
  end
end
