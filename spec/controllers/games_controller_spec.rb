# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:player) { create(:user) }
  let(:opponent) { create(:user) }

  let(:valid_attributes) do
    { player_id: player.id, opponent_id: opponent.id, player_score: 19, opponent_score: 21, played_at: '2019-03-30 18:38:53' }
  end

  let(:invalid_attributes) do
    { player_id: nil, opponent_id: nil, player_score: nil, opponent_score: nil, played_at: nil }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      game = create(:game, valid_attributes)
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
      hash_body = JSON.parse(response.body)
      data = hash_body['data']
      expect(response).to be_successful
      expect(data.first['id'].to_i).to eq(game[:id])
    end

    it 'returns ordered games' do
      first = create(:game, valid_attributes.merge(played_at: '2019-11-30 18:38:53'))
      second = create(:game, valid_attributes.merge(played_at: '2019-04-30 18:38:53'))
      third = create(:game, valid_attributes.merge(played_at: '2019-01-30 18:38:53'))
      get :index, params: {}, session: valid_session
      hash_body = JSON.parse(response.body)
      data = hash_body['data']
      expect(data.first['id'].to_i).to eq(first[:id])
      expect(data.second['id'].to_i).to eq(second[:id])
      expect(data.last['id'].to_i).to eq(third[:id])
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      game = Game.create! valid_attributes
      get :show, params: { id: game.to_param }, session: valid_session
      hash_body = JSON.parse(response.body)
      data = hash_body['data']
      expect(response).to be_successful
      expect(data['id'].to_i).to eq(game[:id])
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Game' do
        expect do
          post :create, params: { game: valid_attributes }, session: valid_session
        end.to change(Game, :count).by(1)
      end

      it 'renders a JSON response with the new game' do
        post :create, params: { game: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new game' do
        post :create, params: { game: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:player) { create(:user) }
      let(:opponent) { create(:user) }

      let(:new_attributes) do
        { player_id: player.id, opponent_id: opponent.id, player_score: 21, opponent_score: 19, played_at: '2019-04-30 18:38:53' }
      end

      it 'updates the requested game' do
        game = Game.create! valid_attributes
        put :update, params: { id: game.to_param, game: new_attributes }, session: valid_session
        game.reload
        expect(game.opponent_id).to be_eql(new_attributes[:opponent_id])
        expect(game.opponent_score).to be_eql(new_attributes[:opponent_score])
        expect(game.played_at.to_date).to be_eql(new_attributes[:played_at].to_date)
        expect(game.player_id).to be_eql(new_attributes[:player_id])
        expect(game.player_score).to be_eql(new_attributes[:player_score])
      end

      it 'renders a JSON response with the game' do
        game = Game.create! valid_attributes

        put :update, params: { id: game.to_param, game: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the game' do
        game = Game.create! valid_attributes

        put :update, params: { id: game.to_param, game: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested game' do
      game = Game.create! valid_attributes
      expect do
        delete :destroy, params: { id: game.to_param }, session: valid_session
      end.to change(Game, :count).by(-1)
    end
  end
end
