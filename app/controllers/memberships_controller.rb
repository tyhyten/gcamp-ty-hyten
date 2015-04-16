class MembershipsController < ApplicationController
  before_action :logged_in?
  before_action :existing_member?
  before_action :project_owner_two?, only: [:new, :create, :edit, :update]
  # before_action :not_last_owner?, only: [:update, :new, :destroy]
  layout 'current_user'
  def index
    @user = current_user
    @project = Project.find(params[:project_id])
    @membership = Membership.new
    @memberships = @project.memberships.all
    @project_owner = Membership.find_by(project_id: @project, user_id: current_user, role: 1) || (current_user.admin == true)

  end

  def new
    @membership = Membership.new
  end

  def create
    @project = Project.find(params[:project_id])
    @membership = Membership.new(membership_params)
    @membership.project_id = @project.id
    if @membership.save
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully added"
    else
      render 'index'
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    @project = Project.find(params[:project_id])
    # if (current_user.id == @membership.user_id) || (current_user.admin == true)
    if @membership.destroy
      redirect_to project_path(@project), alert: "#{@membership.user.full_name} was successfully deleted"
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @membership = Membership.find(params[:id])
    # if !last_owner? || (current_user.admin == true)
    if @membership.update(membership_params)
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully updated"
    else
      redirect_to project_memberships_path(@project)
      flash[:alert] = "Projects must have at least one owner"
    end
  end

  private

    def membership_params
      params.require(:membership).permit(:project_id, :user_id, :role)
    end
end
