require 'rails_helper'

describe 'User can sign in' do
  scenario 'user can sign in successfully' do
    @user = User.create(first_name: "Bald", last_name: "Eagles", email: "baldeagle@aol.com", password: "123456")
    visit '/'
    click_on "Sign In"
    fill_in 'Email', :with => "baldeagle@aol.com"
    fill_in 'Password', :with => "123456"
    click_on "Sign In!"
    click_on "Sign Out"
    expect(page).to have_content "User was successfully signed out"
  end

  scenario 'user redirects to the correct spot upon sign out' do
    @user = User.create(first_name: "Bald", last_name: "Eagles", email: "baldeagle@aol.com", password: "123456")
    visit '/'
    click_on "Sign In"
    fill_in 'Email', :with => "baldeagle@aol.com"
    fill_in 'Password', :with => "123456"
    click_on "Sign In!"
    click_on "Sign Out"
    expect(page).to have_content "gCamp has changed my life!"
  end
end
