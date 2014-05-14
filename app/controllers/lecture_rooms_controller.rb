class LectureRoomsController < ApplicationController

  def index
    @lecture_rooms = current_user.lecture_rooms.page params[:page]
  end

  def new
    @lecture_room = current_user.lecture_rooms.new
  end

  def edit
    @lecture_room = LectureRoom.find params[:id]
  end

  def update
    @lecture_room = LectureRoom.find params[:id]
    @lecture_room.attributes = lecture_room_params

    old_name = @lecture_room.name_was

    if @lecture_room.save
      redirect_to lecture_rooms_path, notice: t('lecture_rooms.messages.updated', name: old_name)
    else
      render :edit
    end
  end

  def create
    @lecture_room = current_user.lecture_rooms.new(lecture_room_params)

    if @lecture_room.save
      redirect_to lecture_rooms_path, notice: t('lecture_rooms.messages.created', name: @lecture_room.name)
    else
      render :new
    end
  end

  def destroy
    lecture_room = LectureRoom.find params[:id]
    if lecture_room.destroy
      redirect_to session.delete(:return_to), notice: t('lecture_rooms.messages.deleted', name: lecture_room.name)
    else
      redirect_to session.delete(:return_to), alert: t('lecture_rooms.messages.not_deleted', name: lecture_room.name)
    end
  end

  private

  def lecture_room_params
    params.require(:lecture_room).permit(:name, :capacity, :description)
  end
end