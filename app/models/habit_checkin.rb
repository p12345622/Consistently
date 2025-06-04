class HabitCheckin < ApplicationRecord
  belongs_to :habit
  validates :checked_on, uniqueness: { scope: :habit_id }
end
