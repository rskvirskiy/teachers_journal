TeachersJournal::Application.routes.draw do
  root to: 'main_page#home'
  devise_for :users

  resources :groups, :subjects, :lecture_rooms, :schedules

  get 'schedules/table_mode/:type_of_week', to: 'schedules#table_mode', as: :schedules_table_mode
end
