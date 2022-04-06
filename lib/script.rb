require 'pry-byebug'
class ConnectFour
  attr_accessor :player_b, :player_r, :game_board, :current_player

  def initialize(board_width = 7, board_height = 7)
    @player_b = Player.new('b', 'Blue')
    @player_r = Player.new('r', 'Red')
    @game_board = create_game_board(board_width, board_height)
    @current_player = @player_b
    @winner = false
  end

  def create_game_board(board_width, board_height)
    game_board = []
    board_width.times { game_board.push(Array.new(board_height)) }
    game_board
  end

  def check_for_win(player, board = @game_board)
    board_height = board_height(board)
    board_width = board_width(board)
    # j for height traversal
    # i for width traversal
    # horizontal checks
    j = 0
    while j < board_height - 3
      i = 0
      while i < board_width
        if board[i][j] == player && board[i][j+1] == player && board[i][j+2] == player && board[i][j+3] == player
          return true
        end
        i += 1
      end
      j += 1
    end

    # vertical checks
    i = 0
    while i < board_width - 3
      j = 0
      while j < board_height
        if board[i][j] == player && board[i+1][j] == player && board[i+2][j] == player && board[i+3][j] == player
          return true
        end
        j += 1
      end
      i += 1
    end

    # ascending diagonal check
    i = 3
    while i < board_width
      j = 0
      while j < board_height - 3
        if board[i][j] == player && board[i-1][j+1] == player && board[i-2][j+2] == player && board[i-3][j+3] == player
          return true
        end
        j += 1
      end
      i += 1
    end

    # descending diagonal check
    i = 3
    while i < board_width
      j = 3
      while j < board_height
        if board[i][j] == player && board[i-1][j-1] == player && board[i-2][j-2] == player && board[i-3][j-3] == player
          return true
        end
        j += 1
      end
      i += 1
    end

    # if no winners
    false
  end

  def board_width(board = @game_board)
    board.length
  end

  def board_height(board = @game_board)
    board[0].length
  end

  def play_game
    while @winner == false
      if check_for_win
        @winner = true
        display_winner(@current_player)
        break
      elsif moves_left(@game_board) == false
        @winner = true
        puts "It looks like you tied! No one wins."
        break
      end
      current_player = get_current_player
    end
  end

  def get_current_player
    if @current_player == @player_b
      @current_player = @player_r
      player = @player_r
    else
      @current_player = @player_b
      player = @player_b
    end
    player
  end

  def display_winner(winner)
    puts "The game is over! #{winner.name} is the winner."
  end

  def moves_left(board)
    board.each_with_index do |value, idx|
      board[idx].each_with_index do |value2, idx2|
        if board[idx][idx2].nil?
          return true
        end
      end
    end
    false
  end
end

class Player
  attr_accessor :symbol, :name

  def initialize(symbol, name)
    @symbol = symbol
    @name = name
  end
end
