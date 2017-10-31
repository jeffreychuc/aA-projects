# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end


  feature 'signing up a user' do
    before(:each) do
      visit new_user_url
      fill_in 'Username', :with => "mr.puddle"
      fill_in 'Password', :with => "biscuits"
      click_on "Submit"
    end
    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content("mr.puddle")
    end
  end
end

feature 'logging in' do
  user = FactoryBot.create(:user)
  before do
    visit new_session_url
    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_button "Log In"
  end
  scenario 'shows username on the homepage after login' do
    expect(page).to have_content(user.username)
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit root_url
    expect(page).to have_content "Find me"
  end
  scenario 'doesn\'t show username on the homepage after logout' do

  end

end
