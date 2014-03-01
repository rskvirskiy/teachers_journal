TeachersJournal::Application.routes.draw do
  root to: 'main_page#home'
  devise_for :users

  resources :groups
  resources :subjects
end
