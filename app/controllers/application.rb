# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '38eb898eac3865c260e4773c9b56ff55'
  
  # Returns a User object for the currently logged in user.
  
  def current_user
    User.find(session[:user_id])    
  end
  
  protected

  def authorize
    unless session[:user_id]
      session[:original_uri] = request.request_uri
      redirect_to(:controller=>"/login", :action=>"index")
    end
  end
end
