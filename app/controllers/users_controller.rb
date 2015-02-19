  class UsersController < ApplicationController

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

    if @user.save
      log_in @user
      redirect_to @user, notice: 'User was successfully created'
    else
      # flash[:alert] = 'There were some errors on the page: '
      # flash[:alert] << "<br>"
      # flash[:alert] << @user.errors.full_messages.join("<br>")
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
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
