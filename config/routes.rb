Rosetta::Engine.routes.draw do
  root to: "locales#index"

  resource :default_locale, only: %i[new create]

  resources :locales do
    scope module: :locales do
      resources :translations, only: :index
      resources :deploys, only: :create

      namespace :translations do
        resources :missing, only: :index
      end
    end
  end

  resources :translation_keys do
    resource :translation, only: %i[edit update]
  end
end
