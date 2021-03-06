# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :player_id
      t.integer :opponent_id
      t.integer :player_score
      t.integer :opponent_score
      t.datetime :played_at

      t.timestamps
    end
  end
end
