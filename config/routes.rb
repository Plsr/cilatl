Rails.application.routes.draw do
  root 'pages#index'
  resources :bookmarks do
    member do
      put :archive
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
