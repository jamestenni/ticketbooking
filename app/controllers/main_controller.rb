class MainController < ApplicationController
  include SessionConcern 
  before_action :initialize_new_user, only: %i[ registerpage register ]
  before_action :set_user, only: %i[ mainpage ]

  def mainpage
    @isLoggedIn = has_logged_in
    # @movies_now_showing = Movie.get_now_showing.in_groups_of(3, false)
    @movies_now_showing = Movie.get_now_showing
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

  def register
    @user.username = params[:user][:username]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    @user.firstname = params[:user][:firstname]
    @user.lastname = params[:user][:lastname]
    @user.email = params[:user][:email]
    @user.birthdate = Date.new(params[:user]["birthdate(1i)"].to_i, params[:user]["birthdate(2i)"].to_i, params[:user]["birthdate(3i)"].to_i)

    if @user.save
      redirect_to login_page_path, notice: "Registration completed! Now you can login to buy some tickets!"
    else
      render :registerpage
    end
  end

  def movietimetablepage
    @movie = Movie.find(params[:id])
    @timetable = @movie.get_showtime_7days
  end

  private
    def initialize_new_user
      @user = User.new()
    end

    def user_params
      params.permit(:username, :password, :password_confirmation, :firstname, :lastname, :email, :birthdate)
    end
end
