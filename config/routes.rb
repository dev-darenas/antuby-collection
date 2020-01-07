Rails.application.routes.draw do
  root 'dashboard#index'
  resources :dashboard, only: :index
  resources :enterprise, only: [:show, :edit, :update]
  resources :products do
    scope module: :products do
      resources :variants
    end
  end

  scope module: 'thirds' do
    resources :clients do
      scope module: :clients do
        resources :contacts
        resources :invoices, only: :index
        resources :activities, only: :index
      end
    end
  end

  namespace :invoices do
    namespace :sales do
      resources :clients, only: :new
    end

    resources :sales do
      resources :activities, only: [:index, :update]
      resources :payments
      namespace :activities do
        resources :visits
        resources :calls
        resources :emails
        resources :payment_promises
        resources :todos
        resources :contacts, only: :new
      end
    end
  end

  resources :option_types
  resources :users
  resources :tasks, only: :index
  resources :notes
  resources :export

  devise_for :users, path: 'user', controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
end
