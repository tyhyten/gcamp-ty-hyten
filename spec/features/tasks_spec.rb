require 'rails_helper'

describe 'User can CRUD tasks' do

  before :each do
    @project = Project.create(name: "projecto")
    @task = Task.create(description: "tasks are for kids, silly rabbit")
    visit '/signup'
    fill_in 'user[first_name]', :with => "Bean"
    fill_in 'user[last_name]', :with => "Wilson"
    fill_in 'user[email]', :with => "bwilson@aol.com"
    fill_in 'user[password]', :with => "123456"
    fill_in 'user[password_confirmation]', :with => "123456"

    click_on "Sign Up!"
    visit '/projects'
    click_on "projecto"
    click_on "New Task"
    fill_in 'task[description]', :with => "vegan dog"
    click_on "Create Task"
  end

  scenario 'User can create a task' do
    expect(page).to have_content "vegan dog"
  end

  scenario 'User can view a task' do
    click_on "Show"
    expect(page).to have_content "vegan dog"
  end

  scenario 'User can update a task' do
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
