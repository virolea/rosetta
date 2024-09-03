Rails.application.routes.draw do
  mount Rosetta::Engine => "/rosetta"

  root to: "pages#home"
end
