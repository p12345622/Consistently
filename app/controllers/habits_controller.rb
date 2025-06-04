class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit, only: [:show, :edit, :update, :destroy, :check_in]

  def index
    @habits = current_user.habits.includes(:habit_checkins)
  end

  def show; end

  def new
    @habit = current_user.habits.build
  end

  def create
    @habit = current_user.habits.build(habit_params)
    if @habit.save
      redirect_to habits_path, notice: "Habit created"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @habit.update(habit_params)
      redirect_to habits_path, notice: "Habit updated"
    else
      render :edit
    end
  end

  def destroy
    @habit.destroy
    redirect_to habits_path, notice: "Habit deleted"
  end

  def check_in
	  @habit = current_user.habits.find(params[:id])
	  date = params[:date] ? Date.parse(params[:date]) : Date.today

	  checkin = @habit.habit_checkins.find_or_initialize_by(checked_on: date)

	  if checkin.new_record?
	    checkin.save
	    flash[:notice] = "Checked in for #{date.strftime('%B %d')}!"
	  else
	    flash[:alert] = "Already checked in for today!"
	  end

	  redirect_to habits_path
	end


  private

  def set_habit
    @habit = current_user.habits.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(:name, :description)
  end
end
