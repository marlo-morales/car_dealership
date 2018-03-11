require "rails_helper"

RSpec.describe "login", type: :feature do
  let(:user) { create(:user) }

  it "allows login with correct details" do
    visit login_path
    fill_in "username", with: user.username
    fill_in "password", with: "Password123"
    click_button "Login"

    expect(current_path).to eq(root_path)
    expect(page).to have_selector(".notification__notice", text: I18n.t("login.create.success"))
  end

  it "prevents login with incorrect username" do
    visit login_path
    fill_in "username", with: "foobar"
    fill_in "password", with: "Password123"
    click_button "Login"

    expect(current_path).to eq(login_path)
    expect(page).to have_selector(".notification__alert", text: I18n.t("login.create.error"))
  end

  it "prevents login with incorrect password" do
    visit login_path
    fill_in "username", with: user.username
    fill_in "password", with: "foobar"
    click_button "Login"

    expect(current_path).to eq(login_path)
    expect(page).to have_selector(".notification__alert", text: I18n.t("login.create.error"))
  end

  it "allows user to logout" do
    login_as(user)

    visit root_path
    click_link "Logout"

    expect(current_path).to eq(root_path)
    expect(page).to have_selector(".notification__notice", text: I18n.t("login.destroy.success"))
  end
end
