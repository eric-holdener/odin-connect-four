require './lib/script.rb'

describe ConnectFour do
  subject(:game) { described_class.new }

  describe '#initialize' do
    context 'when game is initialized' do
      it 'game is created as an object' do
        expect(game).to be_kind_of(ConnectFour)
      end

      it 'has player Blue as an object of player' do
        player = game.player_b
        expect(player).to be_kind_of(Player)
      end

      it 'has player Red as an object of player' do
        player = game.player_r
        expect(player).to be_kind_of(Player)
      end
    end
  end

  describe '#create_game_board' do
    context 'when game board is created' do
      it 'creates an array of length 7' do
        game_board = game.create_game_board
        expect(game_board.length).to be(7)
      end

      it 'creates nested arrays of 7' do
        game_board = game.create_game_board
        expect(game_board[0].length).to be(7)
      end
    end
  end
end

describe Player do
  subject(:player) { described_class.new('b') }

  describe '#initialize' do
    context 'when player object is created' do
      it 'is of type object' do
        expect(player).to be_kind_of(Player)
      end

      it 'has a symbol associated with it' do
        symbol = player.symbol
        expect(symbol).to eq('b')
      end
    end
  end
end