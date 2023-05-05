Rails.application.routes.draw do
# ユーザー用
# URL /users/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

#ゲストログインする時。上のルーティングに混ぜられないか？
devise_scope :user do
  post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
end

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

scope module: :public do
  root to: 'homes#top'
  get '/about' => 'homes#about'
  get '/my_page' => 'users#my_page'
  get 'users/confirm_deleted' => 'users#confirn_deleted', as: 'confirm_deleted'
  patch 'users/is_deleted' => 'users#is_deleted', as: 'is_deleted'
  resources :users, only: [:index, :show, :edit, :updaate] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :posts do
    #favoritesの一覧ページ、参考記事に倣ってcollectionを使ったけど意味はわかっていない
    get :favorites, on: :collection
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  resources :comments, only: [:destroy]
end

namespace :admin do
  resources :users, only: [:index, :show, :edit, :update]
  resources :posts, only: [:index, :show, :destroy]
  resources :comments, only: [:destroy]
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
