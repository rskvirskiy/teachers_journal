TeachersJournal::Application.routes.draw do
	root to: 'main_page#home'
	devise_for :users

	resources :groups, :subjects, :lecture_rooms, :schedules

	get 'schedules/table_mode/:type_of_week', to: 'schedules#table_mode', as: :schedules_table_mode

	resources :timesheets do
		collection do
			get 'auto_generation_settings', to: 'timesheets#auto_generation_settings', as: :auto_generation_settings
			get 'auto_generate', to: 'timesheets#auto_generate', as: :auto_generate
		end
	end
end
