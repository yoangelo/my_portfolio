module LoginTestUser
  def login_test_user(which_user)
    visit root_path
    find("li", text: "ログイン").click
    sleep 2
    fill_in "login_user_email", with: which_user.email
    fill_in "login_user_password", with: which_user.password
    click_on "ログインする"
  end
end
