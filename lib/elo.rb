# frozen_string_literal: true

module Elo
  K = 30

  def calculate_new_raitings(player_raiting, opponent_raiting, player_score, opponent_score)
    player_actual = player_won?(player_score, opponent_score) ? 1 : 0
    opponent_actual = player_won?(player_score, opponent_score) ? 0 : 1

    player_probability = probability(opponent_raiting, player_raiting)
    opponent_probability = probability(player_raiting, opponent_raiting)

    player_new_raiting = player_raiting + K * (player_actual - player_probability)
    opponent_new_raiting = opponent_raiting + K * (opponent_actual - opponent_probability)

    [player_new_raiting.round, opponent_new_raiting.round]
  end

  private

  def probability(rating1, rating2)
    (1.0 * (1.0 / (1 + 1.0 * 10**(1.0 * (rating1 - rating2) / 400))))
  end

  def player_won?(player_score, opponent_score)
    player_score > opponent_score
  end
end
