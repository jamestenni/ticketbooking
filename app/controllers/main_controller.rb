class MainController < ApplicationController
  include SessionConcern 
  before_action :initialize_new_user, only: %i[ registerpage register ]
  before_action :set_user, only: %i[ mainpage inventorypage movietimetablepage selectseatpage ordersummarypage createorder cancelorder confirmorder confirmorderpage]
  before_action :is_logged_in, only: %i[ inventorypage ordersummarypage createorder confirmorderpage]
  before_action :save_previous_url, only: %i[ selectseatpage ]

  def mainpage
    @isLoggedIn = has_logged_in

    if @isLoggedIn 
      @user.change_waiting_order_to_cancel
    end

    @movies_now_showing = Movie.get_now_showing
  end

  def inventorypage
    @isLoggedIn = has_logged_in
    # @tickets = @user.tickets
    @tickets = Ticket.joins(:timetable, :inventory, :chair).where("user_id = ?", @user.id).order("datetime_start DESC, row ASC, column ASC")
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
    User.find_by(id: session[:user_id]).change_waiting_order_to_cancel
    
    session[:user_id] = nil #clear session
    session[:previous_url] = nil
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
    @isLoggedIn = has_logged_in

    if @isLoggedIn 
      @user.change_waiting_order_to_cancel
    end

    @movie = Movie.find(params[:id])
    @timetable = @movie.get_showtime_7days
  end

  def selectseatpage
    @isLoggedIn = has_logged_in

    if @isLoggedIn 
      @user.change_waiting_order_to_cancel
    end

    @movie = Movie.find(params[:m_id])
    @timetable = Timetable.find(params[:s_id])
    @tickets = @timetable.get_tickets
  end

  def createorder
    tickets_select = params.select{|key, value| key.to_s.include?("ticket-") and value.to_i == 1}.keys.to_a
    tickets_id_select = tickets_select.map{|ticket_string| ticket_string[7..-1].to_i}
    
    if tickets_id_select.empty?
      redirect_to session[:previous_url], alert: "You haven't pick any seat, please pick one to proceed"
      session[:previous_url] = nil
      return
    end

    all_seat_available = true
    tickets_id_select.each do |ticket_id|
      ticket = Ticket.find_by(id: ticket_id)
      if ticket == nil or ticket.get_status() == "Reserved"
        all_seat_available = false
        break
      end
    end

    #if the chose seats, has been taken by other users
    if !all_seat_available
      redirect_to session[:previous_url], alert: "Chosen seats are not available at this moment, try others"
      session[:previous_url] = nil
      return
    end
  
    # if all seat is available, we will create an order for this user (status = "waiting" (0)) / also the orderline_items
    @order = Order.create(user_id: @user.id, datetime_place: DateTime.now, status: 0)
    tickets_id_select.each do |ticket_id|

      puts "----------------------------------------------"
      puts "order_id: #{@order.id}"
      puts "ticket_id: #{ticket_id}"
      puts "price: #{Ticket.find_by(id: ticket_id).price}"
      puts "quantity: #{1}"
      puts "----------------------------------------------"

      OrderlineItem.create(order_id: @order.id, ticket_id: ticket_id, price: Ticket.find_by(id: ticket_id).price, quantity: 1)
    end

    redirect_to order_summary_page_path(o_id: @order.id)
    # puts "--------------------------------------"
    # puts tickets_id_select
    # puts "--------------------------------------"
    # puts all_seat_available
  end

  def ordersummarypage
    @isLoggedIn = has_logged_in
    @order = Order.find_by(id: params[:o_id])

    if !is_order_owner(@order) #login but not the user who places an order
      redirect_to main_page_path(), alert: "You don't have permission."
    end
  end

  def cancelorder
    @isLoggedIn = has_logged_in
    @order = Order.find_by(id: params[:o_id])

    if !is_order_owner(@order) #login but not the user who places an order
      redirect_to main_page_path(), alert: "You don't have permission."
    end

    @order.status = "canceled"
    @order.save
    if (!session[:previous_url].nil?)
      redirect_to session[:previous_url], alert: "Your order has been canceled"
      session[:previous_url] = nil
    else
      redirect_to main_page_path(), alert: "Your order has been canceled"
    end
  end

  def confirmorder
    @isLoggedIn = has_logged_in
    @order = Order.find_by(id: params[:o_id])
    if !is_order_owner(@order) #login but not the user who places an order
      redirect_to main_page_path(), alert: "You don't have permission."
    end

    # mark order status to completed
    @order.status = "completed"
    @order.save

    # add all ticket in the order to the user's inventory
    @order.tickets.each do |ticket|
      Inventory.create(user_id: @order.user.id, ticket_id: ticket.id, quantity: 1)
    end

    redirect_to order_confirm_page_path()
  end

  def confirmorderpage
    @isLoggedIn = has_logged_in
    @order = Order.find_by(id: params[:o_id])

    if !is_order_owner(@order) #login but not the user who places an order
      redirect_to main_page_path(), alert: "You don't have permission."
    end
  end

  private
    def initialize_new_user
      @user = User.new()
    end

    def user_params
      params.permit(:username, :password, :password_confirmation, :firstname, :lastname, :email, :birthdate)
    end
end
