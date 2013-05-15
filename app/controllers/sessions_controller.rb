
class SessionsController < ApplicationController
	layout 'login'
	
  def new
  end

  def create
	  user = User.find_by_email_and_disabled(params[:email].downcase, false)
		if user && user.authenticate(params[:password])
			reset_session
		  session[:user_id] = user.id
		  redirect_to root_url
		else
		  flash.now.alert = "Invalid email or password"
		  render "new"
		end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_url 
  end
end

