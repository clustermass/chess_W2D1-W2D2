require_relative 'display'
require_relative 'cursor'
require_relative 'pieces'
require "colorize"
require "byebug"
class Board
    attr_reader :board
  def initialize
    @board = initialize_board
    @color = :white

  end



  def initialize_board
    black_arr = Array.new()
    black_arr << Rook.new(:black, self, [0, 0])
    black_arr << Knight.new(:black, self, [0, 1])
    black_arr << Bishop.new(:black, self, [0, 2])
    black_arr << King.new(:black, self, [0, 3])
    black_arr << Queen.new(:black, self, [0, 4])
    black_arr << Bishop.new(:black, self, [0, 5])
    black_arr << Knight.new(:black, self, [0, 6])
    black_arr << Rook.new(:black, self, [0, 7])
    8.times do |i|
      black_arr << Pawn.new(:black, self, [0, i])
    end

    white_arr = Array.new()
    8.times do |i|
      white_arr << Pawn.new(:white, self, [6, i])
    end
    white_arr << Rook.new(:white, self, [7, 0])
    white_arr << Knight.new(:white, self, [7, 1])
    white_arr << Bishop.new(:white, self, [7, 2])
    white_arr << Queen.new(:white, self, [7, 3])
    white_arr << King.new(:white, self, [7, 4])
    white_arr << Bishop.new(:white, self, [7, 5])
    white_arr << Knight.new(:white, self, [7, 6])
    white_arr << Rook.new(:white, self, [7, 7])

    null_pieces = Array.new(32)
    null_pieces.each_index do |i|
      null_pieces[i] = NullPiece.instance
    end
    board =  black_arr +  null_pieces + white_arr
   p  board.each_slice(8).to_a
  #
  #   ______________________________________________________
  #   @board.flatten.each_index do |i|
  #     if i.between?(0, 15) || i.between?(48, 63)
  # # byebug
  #       @board[i] = Knight.new(:black, self, [4, 4])
  #     else
  #       @board[i] = NullPiece.instance
  #     end
  #   end
  #   @board = @board.each_slice(8).to_a
  end

  def move_piece(color, start_pos, end_pos)

    s_row,s_col = start_pos
    e_row,e_col = end_pos
    if @board[s_row][s_col].class == NullPiece

      # raise "No piece there!"
    elsif @board[s_row][s_col].moves.include?(end_pos) && @color == color && !move_into_check?(end_pos)
      @board[e_row][e_col] = @board[s_row][s_col]
      @board[s_row][s_col] = NullPiece.instance
      @board[e_row][e_col].set_pos(end_pos)
      @color == :white ? @color = :black : @color = :white
    end

  end

  def []=(pos, value)
    row, col = pos
    @board[row][col] = value
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def valid_pos?(pos)
    pos.first.between?(0,7) && pos.last.between?(0,7)
  end

  def in_check?(color, board = @board)
    king_pos = []
    kings_arr = board.flatten.select {|fig| fig.class.to_s == "King"}
    kings_arr = kings_arr.select{|king| king.color == color}
    king_pos = kings_arr.first.pos

    opposite_figs = board.flatten.select {|figs| figs.color != color}
    opposite_figs.each do |fig|
      if fig.moves.include?(king_pos)
        return true
      end
    end
    false
  end

  def move_into_check?(end_pos)
    temp_board = self.deep_dup
    in_check?(@color, temp_board)

  end

  def deep_dup
    @board.map {|el|  el.is_a?(Array) ? el.map {|el|} : el }
  end

  def checkmate?(color)
    kings_arr = @board.flatten.select {|fig| fig.class.to_s == "King"}
    kings_arr.length == 1
  end


end


if __FILE__ == $PROGRAM_NAME
  board = Board.new
   # cur = Cursor.new([0,0], board)
  # p board[[0,1]].moves


  disp = Display.new(board)
  loop do
  disp.render
  disp.cursor.get_input
  end
end
