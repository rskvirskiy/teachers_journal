class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.belongs_to :user

      t.string :name
      t.integer :students_number
      t.text :description

      t.timestamps
    end
  end
end
