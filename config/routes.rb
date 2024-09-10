Rosetta::Engine.routes.draw do
  root to: "locales#index"

  resources :locales do
    scope module: :locales do
      resources :translation_keys, only: :index
    end
  end

  resources :translation_keys do
    resource :translation, only: %i[edit update]
  end
end
