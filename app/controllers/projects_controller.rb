class ProjectsController < ApplicationController
    before_action :logged_in?
    layout 'current_user'
    def index
      @projects = Project.all
    end

    def show
      @project = Project.find(params[:id])
      @memberships = @project.memberships
      @tasks
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

      @project.destroy
      redirect_to projects_path, notice: 'Project was succssfully deleted'
    end

    private

    def project_params
      params.require(:project).permit(:name)
    end

  end
