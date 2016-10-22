Rails.application.routes.draw do
 authenticated do
  root :to => 'posts#index', as: :authenticated
end

root :to => 'static#home'

  devise_for :users 
  resources :posts do 
    resources :comments 
    member do
          post 'like'
     end
  end
  get 'featured',:to => 'posts#featured'
get 'popular',:to => 'posts#popular'
end
