# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'home', to: 'spa#index'

  # Admin routes
  scope :admin, module: :admin do
    resources :users
    resources :feedbacks
  end

  # Employee route
  scope :employee, module: :employee do
    resources :feedbacks
  end

  scope :error do
    get 'not_found', to: 'spa#not_found'
    get 'server_error', to: 'spa#server_error'
  end

  %i[get post put patch delete].each do |http_method|
    send(http_method, '*path', to: 'spa#no_routing')
  end
end
