require "rails_helper"

RSpec.describe "Cars - Buy Car", type: :feature do
  include ActiveJob::TestHelper

  context "for User Story 4" do
    let!(:cars) { create_list(:car, 15, seller: create(:user, :seller)) }
    let!(:admin) { create(:user, admin: true) }
    let(:car) { Car.recent.first }

    before do
      visit root_path
      first(".car-form ~ .car").click_link(I18n.t("cars.buy.text"))
    end

    scenario "Buy car" do
      expect(current_path).to eq buy_car_path(car)
      expect(page).to have_text I18n.t("time.ago", time: app_helpers.time_ago_in_words(car.created_at))
      expect(page).to have_text car.title
      expect(page).to have_text car.seller.name
      expect(page).to have_text car.seller.mobile_number
      expect(page).to have_text car.seller.username
      expect(page).to have_text I18n.t(
        "cars.description", condition: car.condition.titleize,
        price_with_currency: app_helpers.number_to_currency(car.price)
      )
      expect(page).to have_field("car[buyer][name]")
      expect(page).to have_field("car[buyer][mobile_number]")
      expect(page).to have_field("car[buyer][email]")
      expect(page).to have_button("Buy")
      expect(page).to have_link("Cancel")
    end

    scenario "Complete buy form" do
      buyer = build(:user, :buyer)
      fill_in "car[buyer][name]", with: buyer.name
      fill_in "car[buyer][mobile_number]", with: buyer.mobile_number
      fill_in "car[buyer][email]", with: buyer.username
      click_button I18n.t("cars.buy.text").titleize

      expect(current_path).to eq thank_you_car_path(car.reload)
      expect(page).to have_text I18n.t("cars.thank_you.sold.intro", buyer: car.buyer.name)
      expect(page).to have_text I18n.t(
        "cars.thank_you.sold.success",
        title: car.title, price_with_currency: app_helpers.number_to_currency(car.price)
      )
      expect(page).to have_text(
        app_helpers.strip_tags(
          I18n.t("cars.thank_you.sold.in_touch", admin: admin.name) +
          I18n.t("cars.thank_you.sold.take_note_html", id: car.id)
        )
      )
      visit root_path
      expect(first(".car-form ~ .car")).to have_text I18n.t("cars.sold.text")
    end

    scenario "Sold car" do
      car.validate_buyer = true
      car.update(buyer: build(:user, :buyer))
      expect(car.sold?).to be_truthy

      visit root_path
      expect(first(".car-form ~ .car")).to have_text(I18n.t("cars.sold.text"))
                                       .and have_no_text I18n.t("cars.buy.text")
    end

    scenario "Send email to admin" do
      buyer = build(:user, :buyer)
      fill_in "car[buyer][name]", with: buyer.name
      fill_in "car[buyer][mobile_number]", with: buyer.mobile_number
      fill_in "car[buyer][email]", with: buyer.username
      click_button I18n.t("cars.buy.text").titleize

      expect(current_path).to eq thank_you_car_path(car)
      expect(enqueued_jobs.count).to eq 1
      expect(enqueued_jobs.last[:args]).to include("CarMailer", "send_sold_email")
      expect(enqueued_jobs.last[:args].last.values).to include(car.id, admin.email)
    end
  end
end
