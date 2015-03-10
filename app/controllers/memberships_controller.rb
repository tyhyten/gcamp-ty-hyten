class MembershipsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @membership = Membership.new
    @memberships = @project.memberships.all
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
    @membership.destroy
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully deleted"
  end

  def update
    @project = Project.find(params[:project_id])
    @membership = Membership.find(params[:id])
    @membership.update(membership_params)
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully updated"
  end

  private

    def membership_params
      params.require(:membership).permit(:project_id, :user_id, :role)
    end
end
