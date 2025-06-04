class CreateHabitCheckins < ActiveRecord::Migration[7.1]
  def change
    create_table :habit_checkins do |t|
      t.references :habit, null: false, foreign_key: true
      t.date :checked_on

      t.timestamps
    end
  end
end
