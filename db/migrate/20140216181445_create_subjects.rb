class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.belongs_to :user

      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
