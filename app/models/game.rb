# frozen_string_literal: true

class Game < ApplicationRecord
  # -- Constants ------------------------------------------------------------
  min_score = 0
  ERROR_MESSAGES = {
    invalid_score_margin: 'Game score should have a 2 point margin',
    no_winning_score: 'Games need a winning score of at least 21 by one player'
  }.freeze
  # -- Attributes -----------------------------------------------------------

  # -- AR Extensions --------------------------------------------------------

  # -- Relationships --------------------------------------------------------
  belongs_to :user, foreign_key: 'player_id'
  belongs_to :opponent, class_name: 'User'

  # -- Validations ----------------------------------------------------------
  validates :player_id, presence: true
  validates :opponent_id, presence: true
  validates :played_at, presence: true
  validates :player_score, presence: true, numericality: {
    greater_than_or_equal_to: min_score
  }
  validates :opponent_score, presence: true, numericality: {
    greater_than_or_equal_to: min_score
  }
  validate :valid_scores

  # -- Scopes ---------------------------------------------------------------

  # -- Callbacks ------------------------------------------------------------

  # -- Class Methods --------------------------------------------------------
  #
  # -- Instance Methods -----------------------------------------------------
  def scores?
    player_score && opponent_score
  end

  def winning_score?
    player_score >= 21 || opponent_score >= 21
  end

  def valid_score_margin?
    (player_score - opponent_score).abs >= 2
  end

  def valid_scores
    return unless scores?

    unless valid_score_margin?
      errors.add(:base, ERROR_MESSAGES[:invalid_score_margin])
    end

    errors.add(:base, ERROR_MESSAGES[:no_winning_score]) unless winning_score?
  end
end
