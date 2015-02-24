require 'rails_helper'

describe 'User can CRUD projects' do
  before :each do
    @project = Project.create(name: "project pat")
    visit '/signup'
    fill_in 'user[first_name]', :with => "Bean"
    fill_in 'user[last_name]', :with => "Wilson"
    fill_in 'user[email]', :with => "bwilson@aol.com"
    fill_in 'user[password]', :with => "123456"
    fill_in 'user[password_confirmation]', :with => "123456"
    click_on "Sign Up!"

    visit '/projects'
  end

  scenario 'User can create project' do
    click_on 'New Project'
    fill_in 'project[name]', with: "grapefruit"
    click_on 'Create Project'
    expect(page).to have_content "Project was successfully created"
  end

  scenario 'User can view a project' do
    click_on 'project pat'
    expect(page).to have_content "project pat"
  end

  scenario 'User can edit a project' do
    click_on 'project pat'
    click_on 'Edit'
    click_on 'Update Project'
    expect(page).to have_content "Project was successfully edited"
  end

  scenario 'User can delete a project' do
    click_on 'project pat'
    click_on 'Delete'
    expect(page).to have_content "Project was succssfully deleted"
  end
end
