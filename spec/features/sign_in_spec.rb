require 'rails_helper'

describe 'User can sign in' do
  before :each do
    User.create(id: 2, first_name: "Test", last_name: "User", email: "test@user.com", password: "password", admin: false)
    Project.create(id: 2, name: "grapefruit")
    Membership.create(project_id: 2, user_id: 2, role: 1)

  end
  scenario 'user can sign in successfully' do
    visit '/login'
    fill_in 'email', :with => "test@user.com"
    fill_in 'password', :with => "password"
    click_on "Sign In!"
    expect(page).to have_content "User was successfully signed in"
  end

  scenario 'user redirects to the correct spot upon sign in' do
    visit '/login'
    fill_in 'email', :with => "test@user.com"
    fill_in 'password', :with => "password"
    click_on "Sign In!"
    expect(page).to have_content "Project"
  end

  scenario 'user can see validation messages' do
    visit '/login'
    fill_in 'email', :with => "test@user.com"
    fill_in 'password', :with => "wrongpassword"
    click_on "Sign In!"
    expect(page).to have_content "User/Password incorrect"
  end
end
