class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :type_of_week
      t.integer :day_of_week
      t.integer :number

      t.belongs_to :subject
      t.belongs_to :lecture_room
      t.belongs_to :group

      t.belongs_to :user

      t.timestamps
    end
  end
end