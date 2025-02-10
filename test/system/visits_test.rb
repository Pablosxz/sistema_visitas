require "application_system_test_case"

class VisitsTest < ApplicationSystemTestCase
  setup do
    @visit = visits(:one)
  end

  test "visiting the index" do
    visit visits_url
    assert_selector "h1", text: "Visits"
  end

  test "should create visit" do
    visit visits_url
    click_on "New visit"

    fill_in "Employee", with: @visit.employee_id
    fill_in "Sector", with: @visit.sector_id
    fill_in "Unit", with: @visit.unit_id
    fill_in "Visit time", with: @visit.visit_time
    fill_in "Visitor", with: @visit.visitor_id
    click_on "Create Visit"

    assert_text "Visit was successfully created"
    click_on "Back"
  end

  test "should update Visit" do
    visit visit_url(@visit)
    click_on "Edit this visit", match: :first

    fill_in "Employee", with: @visit.employee_id
    fill_in "Sector", with: @visit.sector_id
    fill_in "Unit", with: @visit.unit_id
    fill_in "Visit time", with: @visit.visit_time.to_s
    fill_in "Visitor", with: @visit.visitor_id
    click_on "Update Visit"

    assert_text "Visit was successfully updated"
    click_on "Back"
  end

  test "should destroy Visit" do
    visit visit_url(@visit)
    click_on "Destroy this visit", match: :first

    assert_text "Visit was successfully destroyed"
  end
end
