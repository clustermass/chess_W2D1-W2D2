require 'singleton'

class Piece

  attr_reader :color, :board
  attr_accessor :pos
  def initialize(color, board, pos)
    @moves = []
    @color = color
    @board = board
    @pos = pos
  end

  def set_pos(pos)
    self.pos[0] = pos[0]
    self.pos[1] = pos[1]
  end

  # def valid_moves
  # end


  def to_s
  end

end

class NullPiece < Piece
  include Singleton
    def initialize
    end

    def color
      "no color"
    end
end

module SlidingPiece
  def moves
    move_dirs = self.move_dirs
    result = []
    move_dirs.each do |mov_dir|
      curr_pos = @pos.dup
      while true
        curr_pos[0]+= mov_dir[0]
        curr_pos[1]+= mov_dir[1]
        break unless @board.valid_pos?(curr_pos)
          if @board[curr_pos].is_a?(NullPiece)
            result.push(curr_pos.dup)
            next
          elsif self.color != @board[curr_pos].color
            result.push(curr_pos.dup)
            break
          elsif self.color == @board[curr_pos].color
            break
          end
      end

    end
    result
  end



end

module SteppingPiece
  def moves
    move_dirs = self.move_dirs
    result = []
    move_dirs.each do |mov_dir|
      curr_pos = @pos.dup
      curr_pos[0]+= mov_dir[0]
      curr_pos[1]+= mov_dir[1]
      if @board.valid_pos?(curr_pos)
        if @board[curr_pos].is_a?(NullPiece)
          result << curr_pos.dup
        elsif self.color == @board[curr_pos].color
          next
        elsif self.color != @board[curr_pos].color
          result << curr_pos.dup
        end
      end
    end
    result
  end
end

class Bishop < Piece
  include SlidingPiece

  def initialize(color, board, pos)
    super(color, board, pos)
  end

  def move_dirs
    [[1,1],[-1,-1],[-1,1],[1,-1]]
  end
end


class Queen < Piece
  include SlidingPiece

  def initialize(color, board, pos)
    super(color, board, pos)
  end

  def move_dirs
    [[1,1],[-1,-1],[-1,1],[1,-1],[0,1],[1,0],[-1,0],[0,-1]]
  end
end

class Rook < Piece
  include SlidingPiece

  def initialize(color, board, pos)
    super(color, board, pos)
  end

  def move_dirs
    [[0,1],[1,0],[-1,0],[0,-1]]
  end

end

class King < Piece
  include SteppingPiece

  def initialize(color, board, pos)
    super(color, board, pos)
  end

  def move_dirs
    [[1,1],[-1,-1],[-1,1],[1,-1],[0,1],[1,0],[-1,0],[0,-1]]
  end

end

class Pawn < Piece
  # include SteppingPiece
# separate method
  def initialize(color, board, pos)
    super(color, board, pos)
  end

  def move_dirs
    [[1,1],[-1,-1],[-1,1],[1,-1],[0,1],[1,0],[-1,0],[0,-1]]
  end
end

class Knight < Piece
  include SteppingPiece

  def initialize(color, board, pos)
    super(color, board, pos)
  end

  def move_dirs
    [[1,2],[2,1],[2,-1],[-2,1],[-1,-2],[-2,-1],[-2,1],[-1,2]]
  end

end
