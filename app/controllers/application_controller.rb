class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
   include SessionsHelper

   def current_user
     if session[:user_id]
       User.find(session[:user_id])
     end
   end

   def logged_in?
     if current_user.nil?
       redirect_to root_path
     end
   end
   # ask why having this in the SessionsHelper, which is included in the ApplicationsController isn't working?
end
