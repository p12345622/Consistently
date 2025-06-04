class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @habits = current_user.habits.includes(:habit_checkins)
  end
end
