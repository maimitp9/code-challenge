# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'admin/spa#login'

  namespace :admin do
    namespace :api do
      # Admin routes
      resources :users
      resources :feedbacks
      resource :session, only: %i[create destroy]
    end
    get 'dashboard', to: 'spa#main'

    scope :error do
      get 'not_found', to: 'spa#not_found'
      get 'server_error', to: 'spa#server_error'
    end
  end

  # Employee route
  namespace :employee do
    namespace :api do
      resources :feedbacks
    end

    get 'dashboard', to: 'spa#main'

    scope :error do
      get 'not_found', to: 'spa#not_found'
      get 'server_error', to: 'spa#server_error'
    end
  end

  delete '/employee/api/session', to: 'admin/api/sessions#destroy'

  %i[get post put patch delete].each do |http_method|
    send(http_method, '*path', to: 'admin/spa#no_routing')
  end

  %i[get post put patch delete].each do |http_method|
    send(http_method, '*path', to: 'employee/spa#no_routing')
  end
end
