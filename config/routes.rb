# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'home', to: 'spa#index'

  namespace :api do
    namespace :v1 do
      # Admin routes
      namespace :admin do
        resources :users
        resources :feedbacks
      end

      # Employee route
      namespace :employee do
        resources :feedbacks
      end
    end
  end

  scope :error do
    get 'not_found', to: 'spa#not_found'
    get 'server_error', to: 'spa#server_error'
  end

  %i[get post put patch delete].each do |http_method|
    send(http_method, '*path', to: 'spa#no_routing')
  end
end
