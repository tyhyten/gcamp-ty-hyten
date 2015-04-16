require 'rails_helper'

describe 'User can CRUD tasks' do

  before :each do
    User.create(id: 2, first_name: "Test", last_name: "User", email: "test@user.com", password: "password", admin: false)
    Project.create(id: 2, name: "grapefruit")
    Membership.create(project_id: 2, user_id: 2, role: 1)

    visit '/login'
    fill_in 'email', :with => "test@user.com"
    fill_in 'password', :with => "password"
    click_on "Sign In!"
    visit '/projects'
    click_link("grapefruit", match: :first)
    click_link("New Task", match: :first)
    fill_in 'task[description]', :with => "vegan dog"
    click_on "Create Task"
  end

  scenario 'User can create a task' do
    expect(page).to have_content "vegan dog"
  end

  scenario 'User can view a task' do
    click_on "vegan dog"
    expect(page).to have_content "vegan dog"
  end

  scenario 'User can update a task' do
    click_on "Edit"
    fill_in 'task[description]', :with => "hello grandmother"
    click_on "Update Task"
    expect(page).to have_content "Task was successfully updated."
  end

  scenario 'User can destroy a  task' do
    click_link "delete_icon_test"
    expect(page).to have_content "Task was successfully destroyed."
  end
end
