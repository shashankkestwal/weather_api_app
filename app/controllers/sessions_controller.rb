class SessionsController < ApplicationController
  def new 
  end 
  def create 
    user = User.find_by(email: params[:email])
    if user.present? and user.authenticate(params[:password])
      session[:user_id] = user.id
    else 
      flash[:login_error] = "something went wrong"
    end
    redirect_to root_path
  end 

  def delete
    session.delete(:user_id)
    redirect_to root_path, notice: "Logged Out"
  end   
end 