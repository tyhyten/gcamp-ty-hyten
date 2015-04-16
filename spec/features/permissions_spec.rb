require 'rails_helper'

describe 'Permissions' do
  before :each do
    #admin
    User.create(id: 11, first_name: "Admin", last_name: "User", email: "test@user.com", password: "password", admin: true)
    #user 1
    User.create(id: 22, first_name: "Test", last_name: "Testy", email: "testtesty@user.com", password: "password", admin: false)
    #project 1
    Project.create(id: 11, name: "grapefruit")
    #project 2
    Project.create(id: 14, name: "apple")

    #task 1 for project 1
    Task.create(id: 11, description: "testy", complete: false, project_id: 11)

    Membership.create(project_id: 11, user_id: 22, role: 1)
    Membership.create(project_id: 14, user_id: 22, role: 0)

    visit '/login'
    fill_in 'email', :with => "testtesty@user.com"
    fill_in 'password', :with => "password"
    click_on "Sign In!"

  end

  scenario 'only logged in users can see projects and tasks' do
    visit '/projects'
    expect(page).to have_content "Projects"
  end

  scenario 'Users can add comments to tasks' do
    visit '/projects/11/tasks/11'
    click_on 'Test Testy'
    expect(page).to have_content "Test Testy"
    end

  scenario 'Users can delete projects from the project show page' do
    visit '/projects/11'
    click_on 'Delete'
    expect(page).to have_content "Project was succssfully deleted"

  end

  scenario 'When a user creates a project they should be automatically added as a project owner' do
    visit '/projects/new'
    fill_in 'Name', with: 'test1'
    click_on 'Create Project'
    click_on 'test1'
    click_on '1 Memberships'
    expect(page).to have_content "You are the last owner."
  end

  scenario 'When a user creates a project, they should be redirected to the tasks index page for that project' do
    visit '/projects/new'
    fill_in 'Name', with: 'test1'
    click_on 'Create Project'
    expect(page).to have_content "Project was successfully created"
  end

  scenario 'Only project owners can edit projects' do
    visit '/projects/14/edit'
    expect(page).to have_content "You do not have access."
  end

  scenario 'Only project owners can manage memberships' do
    visit '/projects/11/memberships'
    expect(page).to have_content "Owner"
  end

  scenario 'Nobody should be able to remove the last owner of a project' do
    visit '/projects/11/memberships'
    expect(page).to have_content "You are the last owner."
  end

  scenario 'Logged in users can only edit their own user' do
    visit '/users/11/edit'
    expect(page).to have_content "The page you were looking for doesn't exist."
  end

  scenario 'Admin users can do everything' do
    expect(page).to have_content
  end

  scenario 'Users cannot see email addresses of other users' do
    expect(page).to have_content
  end

  scenario 'Users can only manage tasks under projects that they are members of' do
    expect(page).to have_content
  end

  scenario 'Users can see email addresses of other users who are on the same projects they are on ' do
    expect(page).to have_content
  end

end
