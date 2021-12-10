Rails.application.routes.draw do
  resources :orderline_items
  resources :orders
  resources :inventories
  resources :products
  resources :timetables
  resources :chairs
  resources :theaters
  resources :movies
  resources :users

  get 'main', to: 'main#mainpage', as: 'main_page'

  get 'login', to: 'main#loginpage', as: 'login_page'
  post 'login', to: 'main#checklogin'
  post 'logout', to: 'main#logout', as: 'logout_page'

  get 'register', to: 'main#registerpage', as: 'register_page'
  post 'register', to: 'main#register'

  get 'movie/:id', to: 'main#movietimetablepage', as: 'movie_timetable_page'
  get 'movie/:m_id/showtime/:s_id', to: 'main#selectseatpage', as: 'select_seat_page'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
