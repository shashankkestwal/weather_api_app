class RegistrationsController < ApplicationController
  def new 
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Successfully created account"
    else 
      flash[:alert] = "something went wrong"
      render :new
    end
  end

  def delete
    session.delete(:user_id)
    redirect_to root_path
  end 
  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end