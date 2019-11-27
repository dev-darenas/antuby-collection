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
    end
  end

  namespace :invoices do
    resources :sales do
      resources :activities, only: :index
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
