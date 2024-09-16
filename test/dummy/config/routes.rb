Rails.application.routes.draw do
  mount Rosetta::Engine => "/rosetta"

  root to: "pages#home"

  post "store_test", to: "pages#store_test", as: :store_test
end
