require 'rails_helper'

describe 'User can CRUD projects' do
  before :each do
    
    User.create(id: 2, first_name: "Test", last_name: "User", email: "test@user.com", password: "password", admin: false)
    Project.create(id: 2, name: "grapefruit")
    Membership.create(project_id: 2, user_id: 2, role: 1)

    visit '/login'
    fill_in 'email', :with => "test@user.com"
    fill_in 'password', :with => "password"
    click_on "Sign In!"

    visit '/projects'
  end

  scenario 'User can create project' do
    click_link('New Project', match: :first)
    fill_in 'project[name]', with: "grapefruit"
    click_on 'Create Project'
    expect(page).to have_content "Project was successfully created"
  end

  scenario 'User can view a project' do
    click_link('grapefruit', match: :first)
    expect(page).to have_content "grapefruit"
  end

  scenario 'User can edit a project' do
    click_link('grapefruit', match: :first)
    click_on 'Edit'
    click_on 'Update Project'
    expect(page).to have_content "Project was successfully edited"
  end

  scenario 'User can delete a project' do
    click_link('grapefruit', match: :first)
    click_on 'Delete'
    expect(page).to have_content "Project was succssfully deleted"
  end
end
