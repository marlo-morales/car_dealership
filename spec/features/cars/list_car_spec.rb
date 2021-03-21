require "rails_helper"

RSpec.describe "Cars - List Car", type: :feature do
  context "for User Story 1" do
    before do
      visit root_path

      click_link("List Car")
    end

    scenario "Show the form" do
      expect(page).to have_field("car[seller][name]")
      expect(page).to have_field("car[seller][mobile_number]")
      expect(page).to have_field("car[seller][email]")
      expect(page).to have_field("car[make]")
      expect(page).to have_field("car[model]")
      expect(page).to have_field("car[year]")
      expect(page).to have_field("car[condition]")
      expect(page).to have_field("car[price]")
      expect(page).to have_button("Create Car")
      expect(page).to have_link("Cancel")
    end

    scenario "List a car" do
      car = build(:car)
      fill_in "car[seller][name]", with: car.seller.name
      fill_in "car[seller][mobile_number]", with: car.seller.mobile_number
      fill_in "car[seller][email]", with: car.seller.username
      select car.make.upcase, from: "car[make]", wait: 10
      fill_in "car[model]", with: car.model
      select car.year, from: "car[year]"
      select car.condition.titleize, from: "car[condition]"
      fill_in "car[price]", with: car.price
      click_button "Create Car"

      car = Car.last
      expect(current_path).to eq cars_path
      expect(page).to have_text I18n.t("cars.thank_you", seller_name: car.seller.name)
      expect(page).to have_text I18n.t(
        "cars.submit_success",
        make: car.make, model: car.model, year: car.year,
        condition: car.condition.titleize, price_with_currency: app_helpers.number_to_currency(car.price)
      )
      expect(page).to have_text app_helpers.strip_tags(I18n.t("cars.take_note_html", id: car.id))
    end

    scenario "Incomplete form" do
      car = build(:car)
      fill_in "car[seller][name]", with: car.seller.name
      fill_in "car[seller][mobile_number]", with: car.seller.mobile_number
      fill_in "car[seller][email]", with: car.seller.username
      select car.make.upcase, from: "car[make]", wait: 10
      select car.year, from: "car[year]"
      select car.condition.titleize, from: "car[condition]"
      fill_in "car[price]", with: car.price
      click_button "Create Car"

      expect(current_path).to eq cars_path
      expect(page).to have_selector ".notification__alert"
      error = "* Model can't be blank"
      expect(page).to have_text I18n.t("cars.save_failed", errors: error)
    end
  end
end
