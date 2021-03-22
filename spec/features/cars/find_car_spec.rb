require "rails_helper"

RSpec.describe "Cars - Find Car", type: :feature do
  context "for User Story 2" do
    let!(:cars) { create_list(:car, 15, seller: create(:user)) }

    before { visit root_path }

    scenario "List cars" do
      expect(page).to have_selector ".car .car__title", count: 10
      expect(page).to have_text "Displaying entries 1 - 10 of 15 in total"
      expect(page).to have_text "1 2 Next › Last »"
    end

    scenario "Filter list" do
      car = cars.first
      filter_make = car.make
      select filter_make.upcase, from: "filter_by_make", wait: 10
      click_button "submit_filter"
      expect(page).to have_selector ".car .car__title", count: Car.where(make: filter_make).size
      filter_year = car.year
      select filter_year, from: "filter_by_year"
      click_button "submit_filter"
      expect(page).to have_selector ".car .car__title", count: Car.where(make: filter_make, year: filter_year).size
    end

    scenario "Filter List - no results" do
      select "APOLLO", from: "filter_by_make", wait: 10
      click_button "submit_filter"
      expect(page).to have_selector ".car .car__title", count: 0
      expect(page).to have_text "No results found for your filter"
    end

    scenario "Pagination" do
      expect(page).to have_text "Displaying entries 1 - 10 of 15 in total"
      expect(page).to have_text "1 2 Next › Last »"
      click_link "2", wait: 10
      expect(page).to have_text "Displaying entries 11 - 15 of 15 in total"
      expect(page).to have_text "« First ‹ Prev 1 2"
    end
  end
end
