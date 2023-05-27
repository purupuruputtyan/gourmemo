Rails.application.routes.draw do
# ユーザー用
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

#ゲストログイン用
devise_scope :user do
  post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
end

# 管理者用
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

scope module: :public do
  root to: 'homes#top'
  get '/about' => 'homes#about'
  get 'search' => 'searches#search'
  get '/my_page' => 'users#my_page'
  #「退会する」を押した時に本当に退会するか確認をする画面
  get 'users/confirm_deleted' => 'users#confirm_deleted', as: 'confirm_deleted'
  #退会処理
  patch 'users/is_deleted' => 'users#is_deleted', as: 'is_deleted'
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :posts do
    #favoritesの一覧ページ,いいねした投稿の一覧ページのためon: :collection使用
    get :favorites, on: :collection
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  resources :comments, only: [:destroy]
end

namespace :admin do
  root to: 'posts#index'
  get 'search' => 'searches#search'
  resources :users, only: [:index, :show, :edit, :update]
  resources :posts, only: [:show, :destroy]
  resources :comments, only: [:destroy]
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
