require 'date'

puts "Seeding..."

# Clear existing data
# HabitCheckin.delete_all
# Habit.delete_all
User.delete_all

# Create users
users = User.create!([
  { email: "alice@example.com", password: "password" },
  { email: "bob@example.com", password: "password" },
  { email: "charlie@example.com", password: "password" }
])

puts "Created #{users.count} users"

# Define sample habits
habit_names = [
  "Workout",
  "Read for 30 minutes",
  "Meditate",
  "Drink 2L of water",
  "Learn Ruby"
]

users.each do |user|
  2.times do
    name = habit_names.sample
    habit = user.habits.create!(
      name: name,
      description: "Track your habit: #{name}"
    )

    # Random check-ins over past 20 days
    (0..20).each do |days_ago|
      date = Date.today - days_ago
      # 60% chance of check-in
      if rand < 0.6
        habit.habit_checkins.create!(checked_on: date)
      end
    end
  end
end

puts "Seeding complete!"
