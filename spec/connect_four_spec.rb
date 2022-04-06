require './lib/script.rb'

describe ConnectFour do
  subject(:game) { described_class.new(7, 7) }

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

      it 'has a 7x7 game board' do
        expect(game.game_board.length).to be(7)
      end
    end
  end

  describe '#create_game_board' do
    context 'when game board is created, creates a 7x7 board' do
      it 'sets board height to 7 (array length)' do
        game_board = game.create_game_board(7, 7)
        expect(game_board.length).to be(7)
      end

      it 'sets board height to 7 (nested arrays)' do
        game_board = game.create_game_board(7, 7)
        expect(game_board[0].length).to be(7)
      end
    end
  end

  describe '#check_for_win' do
    context 'checks for a winner of the game algorithmically' do
      it 'returns true for a winner horizontally' do
        board = game.create_game_board(7, 7)
        board[0][0] = 'r'
        board[1][0] = 'r'
        board[2][0] = 'r'
        board[3][0] = 'r'
        expect(game.check_for_win('r', board)).to be true
      end

      it 'returns true for a winner vertically' do
        board = game.create_game_board(7, 7)
        board[0][0] = 'r'
        board[0][1] = 'r'
        board[0][2] = 'r'
        board[0][3] = 'r'
        expect(game.check_for_win('r', board)).to be true
      end

      it 'returns true for a winner ascending diagonally' do
        board = game.create_game_board(7, 7)
        board[3][0] = 'r'
        board[2][1] = 'r'
        board[1][2] = 'r'
        board[0][3] = 'r'
        expect(game.check_for_win('r', board)).to be true
      end

      it 'returns true for a winner descending diagonally' do
        board = game.create_game_board(7, 7)
        board[3][3] = 'r'
        board[2][2] = 'r'
        board[1][1] = 'r'
        board[0][0] = 'r'
        expect(game.check_for_win('r', board)).to be true
      end

      it 'returns false if there is no winner' do
        board = game.create_game_board(7, 7)
        expect(game.check_for_win('r', board)).to be false
      end
    end
  end

  describe '#get width' do
    context 'gets the width of the board' do
      it 'returns 7 for standard board length' do
        expect(game.board_width).to be(7)
      end

      it 'returns 8 for a modified board width' do
        board = game.create_game_board(8, 8)
        expect(game.board_width(board)).to be(8)
      end
    end
  end

  describe '#get height' do
    context 'gets the height of the board' do
      it 'returns 7 for standard board height' do
        expect(game.board_height).to be(7)
      end

      it 'returns 8 for a modified board height' do
        board = game.create_game_board(8, 8)
        expect(game.board_height(board)).to be(8)
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