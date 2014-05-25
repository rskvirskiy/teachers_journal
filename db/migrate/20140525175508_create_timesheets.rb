class CreateTimesheets < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.datetime :date
      t.string :group
      t.string :subject
      t.string :theme
      t.string :type_of_work
      t.float :hours

      t.belongs_to :user
    end
  end
end
