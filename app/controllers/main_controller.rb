class MainController < ApplicationController
  include SessionConcern 
  before_action :initialize_new_user, only: %i[ loginpage registerpage ]
  before_action :set_user, only: %i[ mainpage ]

  def mainpage
    @isLoggedIn = has_logged_in
  end

  def loginpage
    @user = User.new(params.permit(:username, :password))
  end

  def checklogin
    user = User.find_by(username: params[:user][:username])
    if (user != nil and user.authenticate(params[:user][:password]))
      #Login Success
      session[:user_id] = user.id #Save session
      redirect_to main_page_path()
    else
      #Login Failed
      redirect_to login_page_path(), alert: "Your email or password is incorrect!"
    end
  end

  def logout
    session[:user_id] = nil #clear session
    @user = nil
    redirect_to main_page_path()
  end

  def registerpage

  end

  private
    def initialize_new_user
      @user = User.new()
    end

    def user_params
      params.require(:user).permit(:username, :password, :firstname, :lastname, :email, :birthdate)
    end
end
