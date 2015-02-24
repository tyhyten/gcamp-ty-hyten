require 'rails_helper'

describe 'User can CRUD users' do
  before :each do
    @user = User.create(first_name: "Test", last_name: "Testman", email: "email@email.com", password: "CheddarCheese")
    visit '/signup'
    fill_in 'user[first_name]', :with => "Bean"
    fill_in 'user[last_name]', :with => "Wilson"
    fill_in 'user[email]', :with => "bwilson@aol.com"
    fill_in 'user[password]', :with => "123456"
    fill_in 'user[password_confirmation]', :with => "123456"
    click_on "Sign Up!"

  end

  scenario 'User can sign up' do
    expect(page).to have_content "User was successfully created"
  end

  scenario 'User can view a user' do
    visit '/users'
    click_on "Test Testman"
    expect(page).to have_content "Test Testman"
  end

  scenario 'User can edit a user' do
    visit '/users'
    click_on "Test Testman"
    click_on 'Edit'
    click_on 'Update User'
    expect(page).to have_content "User was successfully updated"
  end

  scenario 'User can delete a user' do
    visit '/users'
    click_on "Test Testman"
    click_on 'Edit'
    click_on 'Delete'
    expect(page).to have_content "User was successfully deleted"
  end
end
