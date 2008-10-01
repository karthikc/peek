# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.


class ApplicationController < ActionController::Base
  include HoptoadNotifier::Catcher
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery # :secret => 'e7048d35fe379aba7f44f985217f22ae'
  
  def account
    return session[:account]
  end
  
  def ensure_user_logged_in
    return if account
    flash[:error] = "You are not logged in. Please login to proceed."
    session[:return_to] = request.request_uri
    redirect_to '/login'
  end
    
end
