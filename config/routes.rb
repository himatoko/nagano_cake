Rails.application.routes.draw do
  namespace :admin do
    get '/', to: 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
  
  scope module: :public do
    root to: 'homes#top'
    get '/about', to: 'homes#about', as: :about
    resources :items, only: [:index, :show]
    get "/customers/mypage" , to: 'customers#show', as: 'mypage'
    get "/customers/information/edit" , to: 'customers#edit'
    get "/customers/information" , to: 'customers#update'
    get "/customers/unsubscribe" , to: 'customers#unsubscribe'
    get "/customers/withdraw" , to: 'customers#wothdraw'
    resources :cart_items, only: [:index, :update, :destroy, :create]
    get "/cart_items/destroy_all" , to: "cart_items#destroy_all"
    resources :orders, only: [:new, :create, :index, :show]
    get "/orders/confirm" , to: "orders#confirm"
    get "/orders/thanks" , to: "orders#thanks"
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
