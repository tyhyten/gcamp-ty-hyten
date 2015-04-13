class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
   include SessionsHelper
  before_action :project_memberships
  helper_method :project_owner?
  helper_method :project_owner_membership_index?

   def current_user
     if session[:user_id]
       User.find(session[:user_id])
     end
   end

   def logged_in?
     if current_user.nil?
       redirect_to root_path
     end
   end
   # ask why having this in the SessionsHelper, which is included in the ApplicationsController isn't working?

    def project_memberships
      if current_user
      @projects = current_user.projects
      end
    end

    def existing_member?
      @project = Project.find(params[:project_id])
      unless @project.users.include?(current_user)
        redirect_to projects_path
        flash[:alert] = "You do not have access to that project and are redirected to the projects path"
      end
    end

    def project_owner?
      @project = Project.find(params[:id])
      unless Membership.find_by(project_id: @project, user_id: current_user, role: 1)
        redirect_to project_path(@project)
        flash[:alert] = "You do not have access."
      end
    end

    def project_owner_membership_index?
      @project = Project.find(params[:project_id])
      if Membership.find_by(project_id: @project, user_id: current_user, role: 1)
        true
      else
        false
      end
    end
end
