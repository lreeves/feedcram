Rails.application.routes.draw do
  root 'welcome#index'

  resources :users

  get  'login' => 'users#login'
  post 'authenticate' => 'users#authenticate'

  get 'dashboard' => 'dashboard#index'

  post 'feeds/add' => 'feeds#add'
  get 'feeds/:id/update' => 'feeds#update'
  get 'feeds/:id/unsubscribe' => 'feeds#unsubscribe'
  get 'feeds' => 'feeds#index'
  post 'read' => 'feeds#mark_as_read'
  post 'mark_all_read' => 'feeds#mark_all_read'
  get 'read' => 'feeds#read'
  get 'account' => 'account#index'
  post 'upload' => 'account#upload'
end
