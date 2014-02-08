TeachersJournal::Application.routes.draw do
  get 'main_page/home'

  root to: 'main_page#home'
end
