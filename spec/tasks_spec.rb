require 'rails_helper'

describe 'User can CRUD tasks' do

  scenario 'User can create a  task' do

  @task = Task.create(description: "Test Task 15")

  visit '/'

  click_on "Tasks"

  click_on "New Task"

  fill_in 'task[description]', :with => "Eat some pudding!"

  click_on "Create Task"

  expect(page).to have_content "Task was successfully created."

  end

  scenario 'User can view a task' do

  @task = Task.create(description: "Test Task 15")

  visit '/tasks'

  click_on "Test Task 1"

  expect(page).to have_content "Test Task 1"

  end

  scenario 'User can update a task' do

    @task = Task.create(description: "Test Task 15")

    visit '/tasks'

    click_on "New Task"

    fill_in 'task[description]', :with => "test1"

    click_on "Create Task"

    click_on "Edit"

    click_on "Update Task"

    expect(page).to have_content "Task was successfully updated."

  end

  scenario 'User can destroy a  task' do

  visit '/tasks'

  click_on "New Task"

  fill_in 'task[description]', :with => "test1"

  click_on "Create Task"

  visit '/tasks'

  click_on "Delete"

  expect(page).to have_content "Task was successfully destroyed."

  end
end
