Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)


  resources :petitions do
    collection do
      get :all
      get :search
    end

    resources :signatures, except: [:new] do
      post :confirm_submit
      
      collection do
        post :search
      end
    end

    # resources :new_signatures

    resources :updates, only: [:index]


    get 'add_translation'
    patch 'update_owners'

  end

  resources :updates
  
  #resource :signatures

  root 'petitions#index'

  # STATIC PAGES

  get '/help',    to: 'application#help'
  get '/about',   to: 'application#about'
  get '/privacy', to: 'application#privacy'
  get '/contact', to: 'application#contact'

  post '/contact_form_submit', to: 'application#contact_form_submit'
  
  ###

  get '/signatures/:signature_key/confirm',    to: 'signatures#confirm'
  get '/ondertekening/:signature_key/confirm', to: 'signatures#confirm'
  get '/petitie/:slug',       to: 'petitions#show'
  get '/resolve/:subdomain',  to: 'petitions#show'
end
