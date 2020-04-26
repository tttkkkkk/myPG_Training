Rails.application.routes.draw do
  root 'static_pages#home'

  # 各カテゴリの一覧取得
  get  '/js',         to: 'static_pages#js'
  get  '/jquery',     to: 'static_pages#jquery'
  get  '/rails',      to: 'static_pages#rails'
  # 静的ページ参照
  get  '/help',      to: 'static_pages#help'
  get  '/about',     to: 'static_pages#about'
  get  '/sitemap',   to: 'static_pages#sitemap'
  get  '/contact',   to: 'static_pages#contact'
  # 管理者登録/ログイン
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :account_activations, only: [:edit]
  resources :users
  resources :microposts
  resources :mydashboard, only: [:create, :destroy, :show]
end
