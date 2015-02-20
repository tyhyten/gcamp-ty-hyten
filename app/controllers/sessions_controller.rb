class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      log_in @user
      redirect_to @user
    else
      @user = User.new
      @user.errors[:base] << ("User/Password incorrect")
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
