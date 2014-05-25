class TimesheetsController < ApplicationController

  def index
		@timesheets = current_user.timesheets.order(:date).page params[:page]
  end

  def new
		 @timesheet = current_user.timesheets.new
  end

  def create
	  @timesheet = current_user.timesheets.new(timesheet_params)

	  if @timesheet.save
		  redirect_to timesheets_path, notice: t('timesheet.messages.created')
	  else
		  render :new
	  end
  end

  def edit
	  @timesheet = Timesheet.find params[:id]
  end

  def update
	  @timesheet = Timesheet.find params[:id]
	  @timesheet.attributes = timesheet_params

	  old_theme = @timesheet.theme_was

	  if @timesheet.save
		  redirect_to timesheets_path, notice: t('timesheets.messages.updated', theme: old_theme)
	  else
		  render :edit
	  end
  end

  def destroy
	  timesheet = Timesheet.find params[:id]
	  if timesheet.destroy
		  redirect_to session.delete(:return_to), notice: t('timesheets.messages.deleted', theme: timesheet.theme)
	  else
		  redirect_to session.delete(:return_to), alert: t('timesheets.messages.not_deleted')
	  end
  end

  def auto_generation_settings

  end

  def auto_generate
		TimesheetsAutoGenerateService.new(params[:academic_hours_pro_lecture], params[:minutes_number_pro_academic_hour],
		                                  params[:start_date], params[:finish_date], params[:default_type],
		                                  params[:current_week_type], params[:delete_another], current_user).perform

	  redirect_to timesheets_path
  end

	private

	def timesheet_params
		params.require(:timesheet).permit(:date, :group, :subject, :theme, :type_of_work, :hours)
	end
end