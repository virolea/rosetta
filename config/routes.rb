Rosetta::Engine.routes.draw do
  root to: "locales#index"

  resources :locales
end
