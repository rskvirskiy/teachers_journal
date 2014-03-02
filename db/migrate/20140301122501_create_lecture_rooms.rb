class CreateLectureRooms < ActiveRecord::Migration
  def change
    create_table :lecture_rooms do |t|
      t.belongs_to :user

      t.string :name
      t.integer :capacity
      t.text :description

      t.timestamps
    end
  end
end
