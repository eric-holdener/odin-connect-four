class ConnectFour
  attr_accessor :player_b, :player_r
  def initialize
    @player_b = Player.new('b')
    @player_r = Player.new('r')
    @game_board = create_game_board
  end

  def create_game_board
    game_board = []
    7.times { game_board.push(Array.new(7)) }
    game_board
  end
end

class Player
  attr_accessor :symbol
  def initialize(symbol)
    @symbol = symbol
  end
end