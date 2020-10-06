# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'home', to: 'spa#index'

  namespace :admin do
    namespace :api do
      # Admin routes
      resources :users
      resources :feedbacks
    end
  end

  # Employee route
  namespace :employee do
    namespace :api do
      resources :feedbacks
    end
  end

  scope :error do
    get 'not_found', to: 'admin/spa#not_found'
    get 'server_error', to: 'admin/spa#server_error'
  end

  %i[get post put patch delete].each do |http_method|
    send(http_method, '*path', to: 'admin/spa#no_routing')
  end
end
