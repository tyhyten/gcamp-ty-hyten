class UsersController < ApplicationController
  layout 'current_user'
  before_action :user_valid?, only: [:edit]
  before_action :comember_collection, only: [:index, :show]
  # before_action :
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new

  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    # @user.admin = false
    if @user.save
      log_in @user
      redirect_to new_project_path, notice: 'User was successfully created'
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to users_path(@user), notice: 'User was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.comments.map do |comment|
      comment.user_id = nil
      comment.save
    end 
    if @user.destroy
      log_out
      redirect_to root_path, alert: 'User was successfully deleted'
    end
  end

  def comember_collection
  @comembers = current_user.projects.map do |project|
      project.users
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :admin, :password, :password_confirmation)
  end

  def user_valid?
    @user = User.find(params[:id])
    unless current_user == @user
      render '../../public/404', layout: false
    end
  end

end
