require 'rails_helper'

describe 'User can CRUD tasks' do

  before :each do

  @task = Task.create(description: "tasks are for kids, silly rabbit")
  visit '/'
  click_on 'Sign In'
  fill_in 'email', with: "test1@test1.com"
  fill_in 'password', with: "test1"
  click_on 'Sign In!'

  end

  scenario 'User can create a  task' do

  visit '/tasks'
  click_on "New Task"

  fill_in 'task[description]', :with => "Eat some pudding!"

  click_on "Create Task"

  expect(page).to have_content "Task was successfully created."

  end

  # scenario 'User can view a task' do
  #
  # @task = Task.create(description: "Test Task 15")
  #
  # visit '/tasks'
  #
  # click_on "Test Task 1"
  #
  # expect(page).to have_content "Test Task 1"
  #
  # end
  #
  # scenario 'User can update a task' do
  #
  #   @task = Task.create(description: "Test Task 15")
  #
  #   visit '/tasks'
  #
  #   click_on "New Task"
  #
  #   fill_in 'task[description]', :with => "test1"
  #
  #   click_on "Create Task"
  #
  #   click_on "Edit"
  #
  #   click_on "Update Task"
  #
  #   expect(page).to have_content "Task was successfully updated."
  #
  # end
  #
  # scenario 'User can destroy a  task' do
  #
  # visit '/tasks'
  #
  # click_on "New Task"
  #
  # fill_in 'task[description]', :with => "test1"
  #
  # click_on "Create Task"
  #
  # visit '/tasks'
  #
  # click_on "Delete"
  #
  # expect(page).to have_content "Task was successfully destroyed."
  #
  # end
end
