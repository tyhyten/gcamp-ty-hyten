class ProjectsController < ApplicationController
    before_action :logged_in?
    before_action :project_owner?, only: [:edit, :update,  :destroy]
    layout 'current_user'
    def index
      @user = current_user
      @projects = @user.projects
      @admin_projects = Project.all
    end

    def show
      @project = Project.find(params[:id])
      @memberships = @project.memberships
      @project_owner = Membership.find_by(project_id: @project, user_id: current_user, role: 1) || (current_user.admin == true)
    end

    def new
      @project = Project.new
    end

    def edit
      @project = Project.find(params[:id])
    end

    def create
      @project = Project.new(project_params)
      if @project.save
        @membership = Membership.new
        @membership.project_id = @project.id
        @membership.user_id = current_user.id
        @membership.role = 1
        @membership.save
        redirect_to project_tasks_path(@project), notice: 'Project was successfully created'
      else
        flash[:alert]
        render :new
      end
    end

    def update
      @project = Project.find(params[:id])
      if @project.update(project_params)
        redirect_to projects_path(@project),  notice: 'Project was successfully edited'
      else
        render :edit
      end
    end

    def destroy
      @project = Project.destroy(params[:id])
      if @project.destroy
      redirect_to projects_path, alert: 'Project was succssfully deleted'
      else
       flash[:alert] = "You do not have access."
     end
    end

    private

    def project_params
      params.require(:project).permit(:name)
    end

  end
