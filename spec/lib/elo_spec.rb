# frozen_string_literal: true

require 'elo'
include Elo

RSpec.describe Elo, 'Elo module' do
  context 'calculate_new_raitings' do
    describe 'calculates correct rankings' do
      it 'should allow game with validscores' do
        actual = [1207, 993]
        player_rank = 1200
        opponent_rank = 1000
        player_score = 21
        opponent_score = 19

        new_ranks = calculate_new_raitings(player_rank, opponent_rank, player_score, opponent_score)
        expect(new_ranks).to eql(actual)
      end
    end
  end
end
