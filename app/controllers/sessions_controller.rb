class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = auth.blank? ? User.new_guest : User.from_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
