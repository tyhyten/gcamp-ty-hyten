# require 'rails_helper'
#
# describe 'User can CRUD user' do
#
#   scenario 'User can sign up' do
#
#     visit '/'
#
#     click_on "Users"
#
#     click_on "New User"
#
#     fill_in 'user[first_name]', :with => "Smooth Gary IV"
#     fill_in 'user[last_name]', :with => "Wiiilson"
#     fill_in 'user[email]', :with => "SG@aol.com"
#     fill_in 'user[password]', :with => "123456"
#     fill_in 'user[password_confirmation]', :with => "123456"
#     click_on "Sign Up"
#
#     expect(page).to have_content "User was successfully created"
#
#   end
#
#   scenario 'User can view a user' do
#
#     @user = User.create(first_name: "Test", last_name: "Testman", email: "email@email.com", password: "CheddarCheese")
#
#     visit '/users'
#
#     click_on "Test Testman"
#
#     expect(page).to have_content "Test Testman"
#
#   end
#
# end
