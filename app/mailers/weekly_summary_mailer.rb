class WeeklySummaryMailer < ApplicationMailer
  def summary_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your Weekly Habit Summary')
  end
end
