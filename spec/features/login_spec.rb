require "rails_helper"

RSpec.describe "Login", type: :feature do
  context "for User Story 3" do
    let!(:user) { create(:user, admin: true) }

    before { visit root_path }

    scenario "when viewing login form" do
      click_link "Login"
      expect(page).to have_field("username")
      expect(page).to have_field("password")
      expect(page).to have_button("Login")
      expect(page).to have_link("Cancel")
    end

    scenario "when successfully logged in" do
      login_as(user.username, "mikeymike123")

      expect(current_path).to eq(root_path)
      expect(page).to have_selector(".notification__notice", text: I18n.t("login.create.success"))
      expect(page).to have_link("Logout")
    end

    context "for login failure" do
      scenario "when username is incorrect" do
        login_as("foobar", "mikeymike123")

        expect(current_path).to eq(login_path)
        expect(page).to have_selector(".notification__alert", text: I18n.t("login.create.error"))
      end

      scenario "when password is incorrect" do
        login_as(user.username, "foobar")

        expect(current_path).to eq(login_path)
        expect(page).to have_selector(".notification__alert", text: I18n.t("login.create.error"))
      end
    end

    scenario "when successfully logged out" do
      login_as(user.username, "mikeymike123")
      click_link "Logout"

      expect(current_path).to eq(root_path)
      expect(page).to have_selector(".notification__notice", text: I18n.t("login.destroy.success"))
      expect(page).to have_link("Login")
    end
  end
end
