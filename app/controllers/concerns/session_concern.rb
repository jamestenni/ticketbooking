module SessionConcern extend ActiveSupport::Concern
  def is_logged_in
    if (session[:user_id] != nil)
      return true
    else
      redirect_to login_page_path(), alert: "You need to be logged in first!"
    end     
  end

  def has_logged_in
    return session[:user_id] != nil
  end

  def set_user
    if (has_logged_in)
      @user = User.find(session[:user_id])
    end
  end

  def save_previous_url
    session[:previous_url] = "#{request.fullpath}"
    puts "****************************************"
    puts session[:previous_url]
    # puts session[:user_id]
  end

  def is_order_owner(order)
    return order.user.id == session[:user_id]
  end

  # def logout
  #   session[:user_id] = nil
  #   @user = nil
  #   redirect_to login_page_path()
  # end

end
