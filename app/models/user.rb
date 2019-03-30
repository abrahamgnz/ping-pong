# frozen_string_literal: true

class User < ApplicationRecord
  # -- Constants ------------------------------------------------------------

  # -- Attributes -----------------------------------------------------------

  # -- AR Extensions --------------------------------------------------------

  has_secure_password

  # -- Relationships --------------------------------------------------------

  # -- Validations ----------------------------------------------------------

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /@/ }
  validates :rank, presence: true, numericality: true

  # -- Scopes ---------------------------------------------------------------

  # -- Callbacks ------------------------------------------------------------
  before_validation :set_rank

  # -- Class Methods --------------------------------------------------------
  #
  # -- Instance Methods -----------------------------------------------------

  def full_name
    "#{first_name} #{last_name}"
  end

  def set_rank
    self.rank ||= 0
  end
end
