# frozen_string_literal: true

class GameSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :player_id, :player_score, :opponent_id, :opponent_score, :played_at
end
