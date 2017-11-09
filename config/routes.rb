Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'

  scope module: 'api' do
    namespace :v1 do
      resources :users, only: [:create, :update]
      resources :campaigns do
        get :search, on: :collection
        post :send_emails, on: :member
        post :send_email, on: :member
        get :email, on: :member
      end
      resources :contacts do
        get :search, on: :collection
      end
      resources :tags
    end
  end

  delete '/cleanup', to: 'application#clean_up' if Rails.env.test?
end
