# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :set_game, only: %i[show update destroy]

  # GET /games
  def index
    @games = Game.order(played_at: :desc).all

    render json: GameSerializer.new(@games, is_collection: true).serialized_json
  end

  # GET /games/1
  def show
    render json: GameSerializer.new(@game), status: :created
  end

  # POST /games
  def create
    @game = Game.new(game_params)

    if @game.save
      render json: GameSerializer.new(@game), status: :created
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      render json: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def game_params
    params.require(:game).permit(:player_id, :opponent_id, :player_score, :opponent_score, :played_at)
  end
end
