class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
   include SessionsHelper
  before_action :project_memberships
  helper_method :project_owner?
  helper_method :project_owner_membership_index?
  helper_method :existing_member?
  helper_method :last_owner?
  helper_method :admin_user?
   def current_user
     if session[:user_id]
       User.find(session[:user_id])
     end
   end

   def logged_in?
     if current_user.nil?
       redirect_to login_path
     end
     session[:return_to] = request.fullpath
   end

    def project_memberships
      if current_user
      @projects = current_user.projects
      end
    end

    def existing_member?
      @project = Project.find(params[:project_id])
      unless @project.users.include?(current_user) || (current_user.admin == true)
        redirect_to projects_path
        flash[:alert] = "You do not have access to that project."
      end
    end

    def project_owner?
      @project = Project.find(params[:id])
      unless Membership.find_by(project_id: @project, user_id: current_user, role: 1) || (current_user.admin == true)
        redirect_to project_path(@project)
        flash[:alert] = "You do not have access."
      end
    end

    def project_owner_membership_index?
      @project = Project.find(params[:project_id])
      if Membership.find_by(project_id: @project, user_id: current_user, role: 1) || (current_user.admin == true)
        true
      else
        false
      end
    end

    def last_owner?
      @project = Project.find(params[:project_id])
      @membership_count = @project.memberships.where(role: 1).count
      if @membership_count == 1
        true
      end
    end

    #   @user_memberships = current_user.memberships
    #   @user_memberships_array = @user_memberships.each {|membership| membership}
    #   @user_memberships_array.where(project_id)
    #   @other_memberships = Membership.all
    #   @user_memberships.where(project_id = )
    #   @other_members =
    #
    # end

end
