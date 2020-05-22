require "rails_helper"

RSpec.describe "Reviews", js: true, type: :system do
  let (:current_user) { FactoryBot.create(:user) }
  let (:other_user)   { FactoryBot.create(:user, email: "other_test@test.com") }
  let (:current_rest) { FactoryBot.create(:restaurant) }
  let (:current_rev)  { FactoryBot.create(:review, restaurant_id: current_rest.id, user_id: current_user.id ) }

  describe "ユーザーがログインしているとき" do
    before do
      visit root_path
      find("li", text: "ログイン").click
      fill_in "login_user_email", with: login_user.email
      fill_in "login_user_password", with: login_user.password
      click_on "ログインする"
    end

    describe "現在のユーザーが投稿者と同じとき"do
      let (:login_user) { current_user }

      describe "レビュー投稿" do
        before do
          visit new_restaurant_review_path(restaurant_id: current_rest.id)
        end

        it "投稿ページが表示されること" do
          expect(page).to have_selector 'h1', text: "口コミを投稿する"
          expect(page).to have_content "タグの入力"
        end

        it "投稿できること" do
          fill_in "review_title", with: "test_review_title"
          fill_in "review_body", with: "test_review_body"
          fill_in "review_tag_list", with: "テスト,タグ"
          attach_file "review_review_images_images", "spec/files/画像1.jpg"
          expect {click_button "投稿"}.to change { Review.count }.by(1)
          expect(page).to have_content "作成できました"
          expect(page).to have_content "test_review_title"
          expect(page).to have_content "test_review_body"
          expect(page).to have_content "タグ"
          expect(page).to have_selector "img"
        end
      end

      describe "詳細・編集・削除" do
        before do
          visit restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
        end

        context "レビュー詳細" do
          it "詳細ページが表示されること" do
            expect(page).to have_content "#{current_rest.name}の口コミ"
            expect(page).to have_selector "span", class: "like"
          end
        end

        context "レビュー編集" do
          before do
            click_on "編集する"
          end
          it "編集ページが表示されること" do
            expect(page).to have_selector 'h1', text: '口コミを編集する'
            expect(page).to have_content "タグの入力"
          end

          it "編集できること" do
            fill_in "review_title", with: "TEST_edit"
            fill_in "review_body", with: "test_body_edit"
            fill_in "review_tag_list", with: "テスト,タグ,へんしゅう"
            attach_file "review_review_images_images", "spec/files/画像2.jpg"
            click_button "投稿"
            expect(page).to have_content "更新できました","TEST_edit"
            expect(page).to have_content "test_body_edit"
            expect(page).to have_content "へんしゅう"
            expect(page).to have_selector "img"
          end
        end

        context "レビュー削除" do
          it "削除できること" do
            expect{
              page.accept_confirm { click_on "削除する" }
            }.to change { current_user.review.count }.by(0)
            expect(page).to have_content "削除に成功しました"
          end
        end
      end
    end

    describe "現在のユーザーが投稿者ではないとき" do
      let (:login_user) { other_user }

      describe "詳細・編集・削除" do
        context "レビュー詳細" do
          before do
            visit restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
          end

          it "詳細ページが表示されるが、編集・削除ボタンが表示されないこと" do
            expect(page).to have_content "#{current_rest.name}の口コミ"
            expect(page).to have_selector "span", class: "like"
            expect(page).to_not have_selector 'a', text: "編集する"
            expect(page).to_not have_selector 'a', text: "削除する"
          end
        end

        context "レビュー編集" do
          before do
            visit edit_restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
          end

          it "編集ページが表示されず、詳細ページにリダイレクトされること" do
            expect(page).to have_content "無効なURLです"
            expect(page).to have_content "#{current_rest.name}の口コミ"
          end
        end
      end
    end
  end

  describe "ユーザーがログインしていないとき"do

    describe "レビュー投稿" do
      before do
        visit new_restaurant_review_path(restaurant_id: current_rest.id)
      end

      it "投稿ページが表示されずログインページにリダイレクトされること" do
        expect(page).to have_content "ログインしてください"
        expect(page).to have_selector 'h1', text: 'ログイン'
      end
    end


    describe "詳細・編集・削除" do
      context "レビュー詳細" do
        before do
          visit restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
        end

        it "詳細ページが表示されるが、編集・削除ボタンが表示されないこと" do
          expect(page).to have_content "#{current_rest.name}の口コミ"
          expect(page).to have_selector "span", class: "like"
          expect(page).to_not have_selector 'a', text: "編集する"
          expect(page).to_not have_selector 'a', text: "削除する"
        end
      end

      context "レビュー編集" do
        before do
          visit edit_restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
        end

        it "編集ページが表示されずログインページにリダイレクトされること" do
          expect(page).to have_content "ログインしてください"
          expect(page).to have_selector 'h1', text: 'ログイン'
        end
      end
    end
  end
end
