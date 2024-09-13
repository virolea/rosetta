Rosetta::Engine.routes.draw do
  root to: "locales#index"

  resources :locales do
    scope module: :locales do
      resources :translations, only: :index

      namespace :translations do
        resources :missing, only: :index
      end
    end
  end

  resources :translation_keys do
    resource :translation, only: %i[edit update]
  end
end
