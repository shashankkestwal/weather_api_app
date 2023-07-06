class SessionsController < ApplicationController
  before_action :already_sign_in, only: [:new, :create]

  def new 
  end 

  def create 
    user = User.find_by(email: params[:email])
    if user.present? and user.authenticate(params[:password])
      session[:user_id] = user.id
    else 
      flash[:login_error] = "invalid username or password"
    end
    redirect_to root_path
  end 

  def delete 
    
    session.delete(:user_id)
    redirect_to root_path, notice: "Logged Out"
  end   

  def already_sign_in 
    redirect_to root_path if Current.user
  end
end 