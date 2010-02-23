class LoginController < ApplicationController
  before_filter :authorize, :except => [ 'login', 'logout', 'index' ]

  def login
    redirect_to({ :controller=>"login", :action=>"index" })
  end

  def logout
    session[:user_id] = nil
    redirect_to({ :controller=>"home", :action=>"index" })
  end

  def index
    if request.post?
      user = User.authenticate(params[:login_name], params[:password])
      if user    
        session[:user_id] = user.id
        User.increment_login_count(user.id)
        
        # Redirect to originally requested destination, if available in session
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || { :controller=>"admin", :action=>"index" })
      else
        flash[:notice] = "Invalid login name or password"
      end
    end
  end
  
end