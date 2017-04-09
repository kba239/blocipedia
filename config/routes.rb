Rails.application.routes.draw do
#  get 'charges/index'

#  get 'charges/show'

#  get 'charges/new'

#  get 'charges/edit'

  resources :wikis
  resources :charges, only: [:new, :create]

  devise_for :users
  resources :users, only: [:show] do
    member do
      put :downgrade
    end
  end
  get 'about' => 'welcome#about'

  root 'welcome#index'

end
