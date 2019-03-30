# frozen_string_literal: true

class AddRankColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :rank, :integer
  end
end
