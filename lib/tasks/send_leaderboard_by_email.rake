# frozen_string_literal: true

namespace :send_leaderboard_by_email do
  DAY_IN_SECONDS = 86_400
  task email: :environment do
    loop do
      @users = User.all

      @users.each do |user|
        UserMailer.send_leaderboard(user).deliver_now
      end
    end
  end
end
