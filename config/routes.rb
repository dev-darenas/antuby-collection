Rails.application.routes.draw do
  root 'dashboard#index'
  resources :dashboard, only: :index
  resources :enterprise, only: :show
  resources :products do
    scope module: :products do
      resources :variants
    end
  end

  scope module: 'thirds' do
    resources :clients do
      resources :contacts, module: 'clients'
      resources :invoices, module: 'clients', only: :index
    end
  end

  namespace :invoices do
    namespace :sales do
      resources :clients, only: :new
    end

    resources :sales do
      resources :activities, only: :index
      resources :payments
      namespace :activities do
        resources :visits
        resources :calls
        resources :emails
        resources :payment_promises
        resources :todos
      end
    end
  end

  resources :option_types
  resources :users
  resources :tasks, only: :index

  devise_for :users, path: 'user', controllers: {
    registrations: 'users/registrations',
  }
end
