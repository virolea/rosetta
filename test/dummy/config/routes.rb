Rails.application.routes.draw do
  mount Rosetta::Engine => "/rosetta"
end
