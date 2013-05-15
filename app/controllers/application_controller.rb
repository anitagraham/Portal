# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  layout "application" 

	# force_ssl
private
	def authenticate!
		logger.debug "=============== Authenticating  ==============="
    case request.format
    when Mime::JSON
    	logger.debug "JSON Request"
    else
      if current_user.nil?
	    	redirect_to log_in_url, :alert => "You must log in to access this page"
	    else
	    	logger.debug "Found user #{current_user.Name}"
	  	end
    end
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
	def authenticate_user!
	  if current_user.nil?
	    redirect_to login_url, :alert => "You must first log in to access this page"
	  end
	end
 
  helper_method :current_user
  helper_method :authenticate_user!
  helper_method :authenticate!
end
