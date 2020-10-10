# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'admin/spa#login'

  # Admin routes
  namespace :admin do
    namespace :api do
      resource :session, only: %i[create destroy]
      resources :users
      resources :feedbacks, only: %i[index show create update] do
        collection do
          get ':user_id/user_feedbacks', to: 'feedbacks#user_feedbacks'
        end
      end
      resource :questions, only: %i[create update]
      resource :users_feedbacks, only: %i[create]
    end
  end

  # Employee route
  namespace :employee do
    namespace :api do
      resources :feedbacks, only: %i[create index show]
      resources :feedbacks_questions_answers, only: %i[create]
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
      get '/', to: 'spa#main'
      get 'new', to: 'spa#main'
      get ':id/assign', to: 'spa#main'
    end

    scope :error do
      get 'not_found', to: 'spa#not_found'
      get 'server_error', to: 'spa#server_error'
    end
  end

  # SPA Employee
  namespace :employee do
    get 'dashboard', to: 'spa#main'

    scope :feedbacks do
      get '/', to: 'spa#main'
      get ':id/give_feedback', to: 'spa#main'
    end

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
