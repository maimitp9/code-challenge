# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'admin/spa#login'

  # Admin routes
  namespace :admin do
    namespace :api do
      resources :users
      resources :feedbacks
      resource :session, only: %i[create destroy]
    end
  end

  # Employee route
  namespace :employee do
    namespace :api do
      resources :feedbacks
    end
  end

  delete '/employee/api/session', to: 'admin/api/sessions#destroy'

  # SPA Admin
  namespace :admin do
    get 'dashboard', to: 'spa#main'

    scope :users do
      get '/', to: 'spa#main'
      get 'new', to: 'spa#main'
      get ':id/edit', to: 'spa#main'
      get ':id/show', to: 'spa#main'
    end

    scope :feedbacks do
      get 'new', to: 'spa#main'
      get 'assign_feedback', to: 'spa#main'
    end

    scope :error do
      get 'not_found', to: 'spa#not_found'
      get 'server_error', to: 'spa#server_error'
    end
  end

  # SPA Employee
  scope :employee do
    get 'dashboard', to: 'spa#main'

    scope :error do
      get 'not_found', to: 'spa#not_found'
      get 'server_error', to: 'spa#server_error'
    end
  end

  %i[get post put patch delete].each do |http_method|
    send(http_method, '*path', to: 'admin/spa#no_routing')
  end

  %i[get post put patch delete].each do |http_method|
    send(http_method, '*path', to: 'employee/spa#no_routing')
  end
end
