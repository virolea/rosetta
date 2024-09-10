Rosetta::Engine.routes.draw do
  root to: "locales#index"

  resources :locales do
    resources :translation_keys, only: :index, module: :locales
  end
end
