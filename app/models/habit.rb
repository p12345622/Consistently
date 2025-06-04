class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_checkins, dependent: :destroy

  validates :name, presence: true

  def checkin_dates
    habit_checkins.order(checked_on: :asc).pluck(:checked_on)
  end

  def current_streak
    streak = 0
    today = Date.today

    checkin_dates.reverse.each do |date|
      if date == today || date == today - streak
        streak += 1
      else
        break
      end
    end

    streak
  end

  def longest_streak
    dates = checkin_dates
    return 0 if dates.empty?

    longest = current = 1

    dates.each_cons(2) do |a, b|
      if b == a + 1
        current += 1
        longest = [longest, current].max
      else
        current = 1
      end
    end

    longest
  end

  def consistency_percentage
    return 0 if habit_checkins.count.zero?
    total_days = (Date.today - created_at.to_date).to_i + 1
    (habit_checkins.count.to_f / total_days * 100).round
  end

end
