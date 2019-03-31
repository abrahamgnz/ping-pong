# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def send_leaderboard(user)
    @user = user
    @users = User.order(rank: :desc).all
    mail(to: @user.email, subject: 'Ping pong leaderbord')
  end
end
