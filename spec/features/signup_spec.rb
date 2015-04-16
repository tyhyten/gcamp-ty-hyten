require 'rails_helper'

describe 'User can sign up' do

  before :each do
    visit '/'
    click_on "Sign Up"
    fill_in 'user[first_name]', :with => "Smoove"
    fill_in 'user[last_name]', :with => "Quinoa"
    fill_in 'user[email]', :with => "bwilson@aol.com"
    fill_in 'user[password]', :with => "123456"
    fill_in 'user[password_confirmation]', :with => "123456"

    click_on "Sign Up!"
  end

  scenario 'guest can sign up successfully' do
    expect(page).to have_content "Smoove Quinoa"
  end

  scenario 'guest redirects to the correct spot upon sign up' do
    expect(page).to have_content "Project"
  end

  scenario 'guest can see validation messages' do
    expect(page).to have_content "User was successfully created"
  end
end
