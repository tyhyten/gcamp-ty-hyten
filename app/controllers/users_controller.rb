class UsersController < ApplicationController

  def index
    @users= User.all
  end

  def show
    @users = User.find(params[:id])
  end

  def new
    @users = User.new
  end

  def edit
    @users = User.find(params[:id])
  end

  def create
    @users = User.new(user_params)

    if @users.save
      redirect_to users_path, notice: 'User was successfully created'
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path(@user),  notice: 'User was successfully edited'
    else
      render :edit
    end
  end

  def destroy
    @user = User.destroy(params[:id])

    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

end
