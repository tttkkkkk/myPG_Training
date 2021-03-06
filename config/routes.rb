Rails.application.routes.draw do
  # トップ画面
  root 'static_pages#home'
  # サブ画面
  get  '/sample',     to: 'static_pages#sample'
  get  '/study',     to: 'static_pages#study'
  # 各カテゴリの一覧
  get  '/js',         to: 'static_pages#js'
  get  '/jquery',     to: 'static_pages#jquery'
  get  '/rails',      to: 'static_pages#rails'
  get  '/ruby',      to: 'static_pages#ruby'
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
  resources :microposts do
    member do
      put 'upd_add'
      put 'upd_mns'
    end
  end
  resources :mydashboard, only: [:create, :destroy, :show]
  # 管理者CSV出力
  get    '/download',  to: 'static_pages#download'

  # API呼出
  namespace :api do
    get  '/microposts', to: 'microposts#index'
  end

end
