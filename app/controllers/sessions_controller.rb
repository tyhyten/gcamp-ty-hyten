class SessionsController < ApplicationController
  before_action :set_page

  def set_page
   unless request.referer.include?('/login')
     session[:return_to] = request.referer
   end
  end

  def new
    @user = User.new
    # I think this can be deleted
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      log_in @user
      redirect_to (session[:return_to]) , notice: 'User was successfully signed in'
    else
      @user = User.new # can delete this?
      @user.errors[:base] << ("User/Password incorrect")
      render 'new'
    end
  end

  # redirect_to(session[:return_to] || default)
  #     session[:return_to] = nil


  # def store_return_to
  #   session[:return_to] = request.fullpath
  # end

  def destroy
    log_out
    redirect_to root_path, notice: 'User was successfully signed out'
  end
end
