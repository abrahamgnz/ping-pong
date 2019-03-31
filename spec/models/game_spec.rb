# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  context 'validations' do
    describe 'player_id' do
      it { should validate_presence_of(:player_id) }
    end

    describe 'opponent_id' do
      it { should validate_presence_of(:opponent_id) }
    end

    describe 'player_score' do
      it { should validate_presence_of(:player_score) }
    end

    describe 'opponent_score' do
      it { should validate_presence_of(:opponent_score) }
    end

    describe 'played_at' do
      it { should validate_presence_of(:played_at) }
    end

    describe 'valid_scores' do
      subject { build(:game) }

      it 'should allow game with validscores' do
        @player = create(:user)
        @opponent = create(:user)
        subject['player_id'] = @player.id
        subject['opponent_id'] = @opponent.id
        expect(subject.valid?).to be_truthy
      end

      it 'should add error on game with invalid margin scores' do
        @player = create(:user)
        @opponent = create(:user)
        subject['player_id'] = @player.id
        subject['opponent_id'] = @opponent.id
        subject['opponent_score'] = 20
        subject['player_score'] = 21
        expect(subject.valid?).to be_falsy
      end

      it 'should add error on game without winning score' do
        @player = create(:user)
        @opponent = create(:user)
        subject['player_id'] = @player.id
        subject['opponent_id'] = @opponent.id
        subject['opponent_score'] = 20
        subject['player_score'] = 18
        expect(subject.valid?).to be_falsy
      end
    end
  end

  context 'Elo module' do
  end
end
