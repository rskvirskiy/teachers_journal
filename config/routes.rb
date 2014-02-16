TeachersJournal::Application.routes.draw do
  devise_for :users
  get 'main_page/home'

  root to: 'main_page#home'
end
