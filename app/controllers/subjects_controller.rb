class SubjectsController < ApplicationController

  def index
    @subjects = current_user.subjects.paginate(page: @current_page, per_page: Subject::PER_PAGE)
  end

  def new
    @subject = current_user.subjects.new
  end

  def edit
    @subject = Subject.find params[:id]
  end

  def update
    @subject = Subject.find params[:id]
    @subject.attributes = subject_params

    old_name = @subject.name_was

    if @subject.save
      redirect_to subjects_path, notice: t('subjects.messages.updated', name: old_name)
    else
      render :edit
    end
  end

  def create
    @subject = current_user.subjects.new(subject_params)

    if @subject.save
      redirect_to subjects_path, notice: t('subjects.messages.created', name: @subject.name)
    else
      render :new
    end
  end

  def destroy
    subject = Subject.find params[:id]
    if subject.destroy
      redirect_to session.delete(:return_to), notice: t('subjects.messages.deleted', name: subject.name)
    else
      redirect_to session.delete(:return_to), alert: t('subjects.messages.not_deleted', name: subject.name)
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :description)
  end
end