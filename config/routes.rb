Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'

  scope module: 'api' do
    namespace :v1 do
      resources :dashboard, only: [:index]
      resources :users, only: [:create, :update] do
        get :find_by_email, on: :collection
      end
      resources :campaigns do
        get :search, on: :collection
        post :send_emails, on: :member
        post :send_email, on: :member
        get :email, on: :member
        resources :emails, only: [:index], controller: "campaign_emails" do
          get :opened, on: :member
          get :clicked, on: :member
        end
        post :add_contact, on: :member
        post :destroy_contact, on: :member
      end
      resources :contacts do
        get :search, on: :collection
      end
      resources :tags
    end
  end

  delete '/cleanup', to: 'application#clean_up' if Rails.env.test?
end
