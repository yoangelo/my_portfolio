require "rails_helper"

RSpec.describe "Reviews", js: true, type: :system do
  let(:current_user) { FactoryBot.create(:user) }
  let!(:current_profile) { FactoryBot.create(:profile, name: current_user.username, user_id: current_user.id) }
  let(:other_user) { FactoryBot.create(:user, email: "other_test@test.com") }
  let!(:other_profile) { FactoryBot.create(:profile, name: other_user.username, user_id: other_user.id) }
  let(:current_rest) { FactoryBot.create(:restaurant) }
  let(:current_rev)  { FactoryBot.create(:review, restaurant_id: current_rest.id, user_id: current_user.id) }

  describe "ユーザーがログインしているとき" do
    before do
      login_test_user(login_user)
    end

    describe "現在のユーザーが投稿者と同じとき" do
      let(:login_user) { current_user }

      describe "レビュー投稿" do
        before do
          FactoryBot.create(:category, name: "hoge")
          FactoryBot.create(:category, name: "fuga")
          FactoryBot.create(:category, name: "piyo")
          visit new_restaurant_review_path(restaurant_id: current_rest.id)
        end

        it "投稿ページが表示されること" do
          expect(page).to have_selector 'div', text: "口コミを投稿する"
          expect(page).to have_content "タグの入力"
          expect(page).to have_content "hoge"
        end

        it "投稿できること" do
          fill_in "review_title", with: "test_review_title"
          fill_in "review_body", with: "test_review_body"
          fill_in "review_tag_list", with: "テスト,タグ"
          check "fuga"
          attach_file "review_review_images_images", "spec/files/test_image1.jpg"
          expect { click_button "投稿" }.to change(Review, :count).by(1)
          expect(page).to have_content "作成できました"
          expect(page).to have_content "test_review_title"
          expect(page).to have_content "test_review_body"
          expect(page).to have_content "タグ"
          expect(page).to have_selector "img"
          expect(page).to have_content "fuga"
        end
      end

      describe "詳細・編集・削除" do
        before do
          visit restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
        end

        context "レビュー詳細" do
          it "詳細ページが表示されること" do
            expect(page).to have_content "#{current_rest.name}"
            expect(page).to have_selector "div", class: "like"
          end
        end

        context "レビュー編集" do
          before do
            click_on "編集する"
          end

          it "編集ページが表示されること" do
            expect(page).to have_selector 'div', text: '口コミを編集する'
            expect(page).to have_content "タグの入力"
          end

          it "編集できること" do
            fill_in "review_title", with: "TEST_edit"
            fill_in "review_body", with: "test_body_edit"
            fill_in "review_tag_list", with: "テスト,タグ,へんしゅう"
            attach_file "review_review_images_images", "spec/files/test_image2.jpg"
            click_button "投稿"
            expect(page).to have_content "更新できました", "TEST_edit"
            expect(page).to have_content "test_body_edit"
            expect(page).to have_content "へんしゅう"
            expect(page).to have_selector "img"
          end
        end

        context "レビュー削除" do
          it "削除できること" do
            expect do
              page.accept_confirm { click_on "削除する" }
            end.to change { current_user.review.count }.by(0)
            expect(page).to have_content "削除に成功しました"
          end
        end
      end
    end

    describe "現在のユーザーが投稿者ではないとき" do
      let(:login_user) { other_user }

      describe "詳細・編集・削除" do
        context "レビュー詳細" do
          before do
            visit restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
          end

          it "詳細ページが表示されるが、編集・削除ボタンが表示されないこと" do
            expect(page).to have_content "#{current_rest.name}"
            expect(page).to have_selector "div", class: "like"
            expect(page).not_to have_selector 'a', text: "編集する"
            expect(page).not_to have_selector 'a', text: "削除する"
          end
        end

        context "レビュー編集" do
          before do
            visit edit_restaurant_review_path(restaurant_id: current_rest.id, id: current_rev.id)
          end

          it "編集ページが表示されず、詳細ページにリダイレクトされること" do
            expect(page).to have_content "無効なURLです"
            expect(page).to have_content "#{current_rest.name}"
          end
        end
      end
    end
  end

  describe "ユーザーがログインしていないとき" do
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
          expect(page).to have_content "#{current_rest.name}"
          expect(page).to have_selector "div", class: "like"
          expect(page).not_to have_selector 'a', text: "編集する"
          expect(page).not_to have_selector 'a', text: "削除する"
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
