ForteManager::Engine.routes.draw do
  if ForteManager.server
    namespace :api do
      resources :transactions do
        collection do
          get :statuses
          get :actions
          get :response_codes
        end
      end
    end
  end

  if ForteManager.client
    resources :transactions
    root 'transactions#index'
  end
end
