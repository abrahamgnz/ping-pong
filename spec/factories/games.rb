# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    player_id 1
    opponent_id 2
    player_score 21
    opponent_score 19
    played_at '2019-03-30'
  end
end
