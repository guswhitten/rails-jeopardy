require 'rails_helper'

RSpec.describe GameDecorator do
  let(:game) { Game.new(player_score: 0, bot_score: 0) }
  let(:decorator) { described_class.new(game) }

  describe '#format_player_score' do
    it 'handles when player score is positive' do
      game.player_score = 100
      expect(decorator.format_player_score).to eq('$100')
    end

    it 'handles when player score is 0' do
      game.player_score = 0
      expect(decorator.format_player_score).to eq('$0')
    end

    it 'handles when player score is negative' do
      game.player_score = -100
      expect(decorator.format_player_score).to eq('-$100')
    end
  end

  describe '#format_bot_score' do
    it 'handles when bot score is positive' do
      game.bot_score = 100
      expect(decorator.format_bot_score).to eq('$100')
    end

    it 'handles when bot score is 0' do
      game.bot_score = 0
      expect(decorator.format_bot_score).to eq('$0')
    end

    it 'handles when bot score is negative' do
      game.bot_score = -100
      expect(decorator.format_bot_score).to eq('-$100')
    end
  end
end