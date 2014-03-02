class GroupsController < ApplicationController
  def index
    @groups = current_user.groups.paginate(page: @current_page, per_page: Group::PER_PAGE)
  end

  def new
    @group = current_user.groups.new
  end

  def edit
    @group = Group.find params[:id]
  end

  def update
    @group = Group.find params[:id]
    @group.attributes = group_params

    old_name = @group.name_was

    if @group.save
      redirect_to groups_path, notice: t('groups.messages.updated', name: old_name)
    else
      render :edit
    end
  end

  def create
    @group = current_user.groups.new(group_params)

    if @group.save
      redirect_to groups_path, notice: t('groups.messages.created', name: @group.name)
    else
      render :new
    end
  end

  def destroy
    group = Group.find params[:id]
    if group.destroy
      redirect_to session.delete(:return_to), notice: t('groups.messages.deleted', name: group.name)
    else
      redirect_to session.delete(:return_to), alert: t('groups.messages.not_deleted', name: group.name)
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :students_number, :description)
  end
end