class SchedulesController < ApplicationController
  before_action :store_request_url, only: [:edit, :destroy]
  before_action :prepare_for_index, only: [:index, :table_mode]

  def index
  end

  def table_mode
    @schedules_numbers = (1..Schedule.get_max_value_of_number).to_a

    render 'schedules/table_mode/index'
  end

  def new
    @schedule = current_user.schedules.new
  end

  def create
    @schedule = current_user.schedules.new do |sch|
      sch.type_of_week = schedules_params[:type_of_week]
      sch.day_of_week  = schedules_params[:day_of_week]
      sch.number       = schedules_params[:number]

      if schedules_params[:subject_name]
        sch.subject = current_user.subjects.find_or_create_by(name: schedules_params[:subject_name])
      end

      if schedules_params[:lecture_room_name]
        sch.lecture_room = current_user.lecture_rooms.find_or_create_by(name: schedules_params[:lecture_room_name])
      end

      if schedules_params[:group_name]
        sch.group = current_user.groups.find_or_create_by(name: schedules_params[:group_name])
      end
    end

    if @schedule.save
      redirect_to schedules_path, notice: t('schedules.messages.created')
    else
      render :new
    end
  end

  def edit
    @schedule = Schedule.find params[:id]
  end

  def update
    @schedule = Schedule.find params[:id]

    @schedule.tap do |sch|
      sch.type_of_week = schedules_params[:type_of_week]
      sch.day_of_week  = schedules_params[:day_of_week]
      sch.number       = schedules_params[:number]

      sch.subject      = current_user.subjects.find_or_create_by(name: schedules_params[:subject_name]) if schedules_params[:subject_name]

      if schedules_params[:lecture_room_name]
        sch.lecture_room = current_user.lecture_rooms.find_or_create_by(name: schedules_params[:lecture_room_name])
      end

      sch.group = current_user.groups.find_or_create_by(name: schedules_params[:group_name]) if schedules_params[:group_name]
    end

    if @schedule.save
      redirect_to session.delete(:return_to) || schedules_path, notice: t('schedules.messages.updated')
    else
      render :edit
    end
  end

  def destroy
    schedule = Schedule.find params[:id]
    if schedule.destroy
      redirect_to session.delete(:return_to) || schedules_path, notice: t('schedules.messages.deleted')
    else
      redirect_to session.delete(:return_to) || schedules_path, alert: t('schedules.messages.not_deleted')
    end
  end

  private

  def schedules_params
    params.require(:schedule).permit(:type_of_week, :day_of_week, :number, :subject_name,
                                     :lecture_room_name, :group_name)
  end

  def prepare_for_index
    @week_types   = Schedule.get_uniq_values_of(:type_of_week, current_user)
    @current_type = params[:type_of_week] || @week_types.last
    @schedules    = current_user.schedules.where(type_of_week: @current_type)
    @days_of_week = (1..7).to_a
  end
end