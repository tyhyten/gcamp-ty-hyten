require 'rails_helper'

describe 'User can CRUD tasks' do

  before :each do
  # @user = User.create(first_name: "Gary", last_name: "Wilson", email: "gw@aol.com", password: "beefwonder")
  @task = Task.create(description: "tasks are for kids, silly rabbit")
  visit '/signup'
  fill_in 'user[first_name]', :with => "Bean"
  fill_in 'user[last_name]', :with => "Wilson"
  fill_in 'user[email]', :with => "bwilson@aol.com"
  fill_in 'user[password]', :with => "123456"
  fill_in 'user[password_confirmation]', :with => "123456"
  click_on "Sign Up!"
  visit '/tasks'

  end

  scenario 'User can create a task' do

  click_on 'New Task'

  fill_in 'task[description]', :with => "Eat some pudding!"

  click_on "Create Task"

  expect(page).to have_content "Task was successfully created."

  end

  scenario 'User can view a task' do

  click_on "tasks are for kids, silly rabbit"

  expect(page).to have_content "tasks are for kids, silly rabbit"

  end

  scenario 'User can update a task' do

    click_on "tasks are for kids, silly rabbit"

    click_on "Edit"

    fill_in 'task[description]', :with => "hello grandmother"

    click_on "Update Task"

    expect(page).to have_content "Task was successfully updated."

  end

  scenario 'User can destroy a  task' do
    
  click_on "Delete"

  expect(page).to have_content "Task was successfully destroyed."

  end
end
