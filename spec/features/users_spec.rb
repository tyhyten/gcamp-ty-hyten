require 'rails_helper'

describe 'User can CRUD users' do
  before :each do
    User.create(id: 2, first_name: "Test", last_name: "User", email: "test@user.com", password: "password", admin: true)
    User.create(id: 4, first_name: "Test", last_name: "Boy", email: "test@boy.com", password: "password", admin: false)
    Project.create(id: 2, name: "grapefruit")
    Membership.create(project_id: 2, user_id: 2, role: 1)
  end


  scenario 'User can sign up' do
    visit '/signup'

    fill_in 'user[first_name]', :with => "Bean"
    fill_in 'user[last_name]', :with => "Wonder"
    fill_in 'user[email]', :with => "bwonder@aol.com"
    fill_in 'user[password]', :with => "123456"
    fill_in 'user[password_confirmation]', :with => "123456"
    click_on "Sign Up!"

    expect(page).to have_content "User was successfully created"
  end

  scenario 'User can view a user' do
    visit '/login'
    fill_in 'email', :with => "test@user.com"
    fill_in 'password', :with => "password"
    click_on "Sign In!"

    visit '/users'
    click_link("Test User", match: :first)
    expect(page).to have_content "Test User"
  end

  scenario 'User can edit a user' do
    visit '/login'
    fill_in 'email', :with => "test@user.com"
    fill_in 'password', :with => "password"
    click_on "Sign In!"

    visit '/users'
    click_link("Test User", match: :first)
    click_on 'Edit'
    click_on 'Update User'
    expect(page).to have_content "User was successfully updated"
  end

  scenario 'User can delete a user' do
    visit '/login'
    fill_in 'email', :with => "test@user.com"
    fill_in 'password', :with => "password"
    click_on "Sign In!"

    visit '/users'
    click_link("Test User", match: :first)
    click_on 'Edit'
    click_on 'Delete'
    expect(page).to have_content "User was successfully deleted"
  end
end
