Rails.application.routes.draw do
  resources :orderline_items
  resources :inventories
  resources :tickets
  resources :orders
  resources :timetables
  resources :chairs
  resources :theaters
  resources :movies
  resources :users

  get 'main', to: 'main#mainpage', as: 'main_page'
  get 'inventory', to:'main#inventorypage', as: 'inventory_page'

  get 'login', to: 'main#loginpage', as: 'login_page'
  post 'login', to: 'main#checklogin'
  post 'logout', to: 'main#logout', as: 'logout_page'

  get 'register', to: 'main#registerpage', as: 'register_page'
  post 'register', to: 'main#register'

  get 'movie/:id', to: 'main#movietimetablepage', as: 'movie_timetable_page'
  get 'movie/:m_id/showtime/:s_id', to: 'main#selectseatpage', as: 'select_seat_page'

  post 'order/create', to: 'main#createorder', as: 'order_create_page'
  get '/order/confirm/:o_id', to: 'main#confirmorderpage', as: 'order_confirm_page'
  post 'order/confirm/:o_id', to: 'main#confirmorder'
  post 'order/cancel/:o_id', to: 'main#cancelorder', as: 'order_cancel_page'
  get 'order/summary/:o_id', to: 'main#ordersummarypage', as: 'order_summary_page'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
