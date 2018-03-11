module LoginMacro
  def login_as(user)
    visit login_path
    fill_in "username", with: user.username
    fill_in "password", with: "Password123"
    click_button "Login"

    expect(current_path).to eq(root_path)
    expect(page).to have_selector(".notification__notice", text: I18n.t("login.create.success"))
  end
end
