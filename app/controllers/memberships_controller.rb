class MembershipsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @membership = Membership.new
    @memberships = @project.memberships
  end

  def create
    @project = Project.find(params[:project_id])
    @membership = Membership.new(membership_params)
    @membership.project_id = @project.id
    if @membership.save
      redirect_to project_memberships_path(@project)
    else
      render 'new'
    end
  end

  private

    def membership_params
      params.require(:membership).permit(:project_id, :user_id, :role)
    end

end
