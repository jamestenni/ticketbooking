Rails.application.routes.draw do
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

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
