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

      it 'has a default 7x7 game board' do
        expect(game.game_board.length).to be(7)
      end

      it 'sets current_player to player_b to start' do
        expect(game.current_player.symbol).to eq('b')
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

  describe '#get current player' do
    context 'based on last player, gets the current player' do
      it 'Returns player_b when current player is player_r' do
        game.current_player = game.player_r
        expect(game.get_current_player.symbol).to eq('b')
      end

      it 'Returns player_r when current player is player_b' do
        game.current_player = game.player_b
        expect(game.get_current_player.symbol).to eq('r')
      end
    end
  end

  describe '#display winner' do
    context 'Writes a message to console with the winner of the game' do
      it 'Outputs the winner blue if the winner is blue' do
        message = "The game is over! Blue is the winner.\n"
        expect { game.display_winner(game.player_b) }.to output(message).to_stdout
      end
    end
  end

  describe '#moves_left' do
    context 'returns true / false depending on if there are moves left on the board' do
      it 'returns true if there are moves left' do
        board = game.game_board
        expect(game.moves_left(board)).to be true
      end

      it 'returns false if there are no moves left' do
        board = game.create_game_board(7, 7)
        board.each_with_index do |value, idx|
          board[idx].each_with_index do |value2, idx2|
            board[idx][idx2] = 'not empty'
          end
        end
        expect(game.moves_left(board)).to be false
      end
    end
  end

  describe '#valid moves' do
    context 'given the game board, returns all valid moves' do
      it 'returns a full array of valid moves with an empty game board' do
        board = game.game_board
        test = game.valid_moves(board)
        expected = [0, 1, 2, 3, 4, 5, 6]
        expect(test).to eq(expected)
      end

      it 'returns a partial array of moves based on empty locations on game board' do
        board = game.game_board
        board.each_with_index do |value, idx|
          board[idx].each_with_index do |value2, idx2|
            if idx == 0
              board[idx][idx2] = 'r'
            end
          end
        end
        test = game.valid_moves(board)
        expected = [1, 2, 3, 4, 5, 6]
        expect(test).to eq(expected)
      end

      it 'returns an empty array if there are no moves left' do
        board = game.game_board
        board.each_with_index do |value, idx|
          board[idx].each_with_index do |value2, idx2|
            board[idx][idx2] = 'r'
          end
        end
        test = game.valid_moves(board)
        expected = []
        expect(test).to eq(expected)
      end
    end
  end

  describe '#update board' do
    context 'puts the proper player symbol in the lowest index of the row the player chose' do
      it 'places at index[0][0] symbol b for player blue selecting row 0 and row 0 is empty' do
        symbol = game.player_b.symbol
        player_move = 0
        board = game.game_board
        board = game.update_board(symbol, player_move, board)
        expect(board[0][0]).to eq('b')
      end

      it 'places move at [0][2] if [0][0] and [0][1] have moves already' do
        symbol = game.player_b.symbol
        player_move = 0
        board = game.game_board
        board[0][0] = 'r'
        board[0][1] = 'b'
        board = game.update_board(symbol, player_move, board)
        expect(board[0][2]).to eq('b')
      end
    end
  end
end

describe Player do
  subject(:player) { described_class.new('b', 'blue') }

  describe '#initialize' do
    context 'when player object is created' do
      it 'is of type object' do
        expect(player).to be_kind_of(Player)
      end

      it 'has a symbol associated with it' do
        symbol = player.symbol
        expect(symbol).to eq('b')
      end

      it 'has a name associated with it' do
        name = player.name
        expect(name).to eq('blue')
      end
    end
  end

  describe '#get move' do
    context 'When the user enters a valid move' do
      before do
        user_input = '6'
        allow(player).to receive(:gets).and_return(user_input)
      end

      it 'accepts a valid move and returns the move, formatted' do
        expect(player.get_move(7)).to eq(6)
      end
    end

    context 'When the user enters an invalid move and then a valid move' do
      before do
        invalid_input = '11'
        user_input = '6'
        allow(player).to receive(:gets).and_return(invalid_input, user_input)
      end

      it 'rejects an invalid move and prompts the user again' do
        width = 7
        error_message = "Input error! Please enter a number between 0 and #{width}."
        expect(player).to receive(:puts).with(error_message)
        player.get_move(width)
      end
    end

    context 'When the user enters an invalid input then a valid input' do
      before do
        invalid_input = 'hello'
        user_input = '6'
        allow(player).to receive(:gets).and_return(invalid_input, user_input)
      end

      it 'rejects invalid inputs (letters, etc) and prompts the user again' do
        width = 7
        error_message = "Input error! Please enter a number between 0 and #{width}."
        expect(player).to receive(:puts).with(error_message)
        player.get_move(width)
      end
    end
  end

  describe '#verify input' do
    context 'verifies the user input is within the scope of the game' do
      it 'returns number for an input within the width of the game board' do
        number = player.verify_input(7, 6)
        expect(number).to eq(6)
      end

      it 'returns nil for an input greater than the width of the game board' do
        number = player.verify_input(7, 8)
        expect(number).to eq(nil)
      end

      it 'returns nil for an input less than 0' do
        number = player.verify_input(7, -3)
        expect(number).to eq(nil)
      end
    end
  end
end
