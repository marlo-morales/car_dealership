require "rails_helper"

RSpec.describe "Cars - Make Car Available", type: :feature do
  context "for User Story 5" do
    let!(:cars) { create_list(:car, 15, seller: create(:user, :seller)) }
    let!(:admin) { create(:user, admin: true) }
    let(:car) { Car.recent.first }

    before do
      car.update(buyer_id: create(:user, :buyer).id)
      login_as(admin.username, "mikeymike123")
    end

    scenario "Make available" do
      expect(current_path).to eq root_path
      first(".car-form ~ .car").click_link(I18n.t("cars.unsold.text"))
      expect(current_path).to eq root_path
      expect(first(".car-form ~ .car--border")).to have_no_link(I18n.t("cars.unsold.text"))
                                               .and have_link I18n.t("cars.buy.text")
    end

    scenario "Not logged in cannot make available" do
      expect(first(".car-form ~ .car--border")).to have_link(I18n.t("cars.unsold.text"))
                                               .and have_no_link I18n.t("cars.buy.text")
      click_link "Logout"
      expect(current_path).to eq root_path
      expect(first(".car-form ~ .car--border")).to have_no_link(I18n.t("cars.unsold.text"))
                                               .and have_no_link I18n.t("cars.buy.text")
    end

    scenario "Available cars don't have button" do
      expect(current_path).to eq root_path
      expect(first(".car-form ~ .car--border")).to have_link(I18n.t("cars.unsold.text"))
                                               .and have_no_link I18n.t("cars.buy.text")
      expect(first(".car-form ~ .car--border:nth-child(10)")).to have_no_link(I18n.t("cars.unsold.text"))
                                                             .and have_link I18n.t("cars.buy.text")
    end
  end
end
