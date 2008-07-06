class UserController < ApplicationController
  
  def logout
    session[:account] = nil
    redirect_to :action => 'login'
  end
  
  def authenticate
    account = Account.login(params[:sub_domain], params[:email_address], params[:password])
    if(account)
      session[:account] = account
      redirect_to(session[:return_to] || '/peek/2')
      session[:return_to] = nil
    else
      flash[:error] = 'Login failed. Please try again.'
      session[:account] = nil
      render :action => 'login'
    end
  end

end