Rails.application.routes.draw do
  root 'lists#index'

  resources :lists do
    member do
      delete :soft_destroy
      patch :restore
    end
    resources :items do
      member do
        delete :soft_destroy
        patch :restore
      end
    end
  end

end