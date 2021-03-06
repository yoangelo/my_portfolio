require "rails_helper"

RSpec.describe "Like", type: :system do
  let(:current_user) { FactoryBot.create(:user) }
  let!(:current_profile) { FactoryBot.create(:profile, name: current_user.username, user_id: current_user.id) }
  let(:other_user)   { FactoryBot.create(:user, email: "other_test@test.com", username: "other") }
  let(:current_rest) { FactoryBot.create(:restaurant) }
  let(:current_rev)  { FactoryBot.create(:review, restaurant_id: current_rest.id, user_id: current_user.id) }
  let(:current_like) { FactoryBot.create(:comment, review_id: current_rev.id, user_id: current_user.id) }

  describe "ユーザーがログインしているとき", js: true do
    before do
      login_test_user(login_user)
      visit restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
    end

    context "いいねができること" do
      let(:login_user) { current_user }

      it "いいねをしたあとに解除もできること" do
        find("i", id: "uniine_like").click
        expect(page).to have_selector "i", id: "iine_like"
        expect(page).to have_selector 'span', text: "1"
        find("i", id: "iine_like").click
        expect(page).to have_selector "i", id: "uniine_like"
        expect(page).to have_selector 'span', text: "0"
      end
    end
  end

  describe "ユーザーがログインしていないとき" do
    before do
      visit restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
    end

    it "いいねができないこと" do
      find("i", id: "uniine_like").click
      expect(page).not_to have_selector "i", id: "iine_like"
      expect(page).to have_selector 'span', text: "0"
    end
  end
end
