require 'colorize'
require_relative 'cursor'
require 'byebug'


class Display

  attr_reader :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)

  end

  def render
    system "clear"
    cursor_pos = @cursor.cursor_pos
    start_color = []
    start_color = @cursor.start_pos if @cursor.start_pos != nil
    8.times do |i|
      temp_row = ""
      8.times do |j|
        # debugger

        if [i, j] == cursor_pos
          temp_row << "▵ "
          next

        else

          # p @board[[i, j]].color
        # if @board[[i, j]].class == Rook
        #   if @board[[i, j]].color == :black
        #     temp_row << '♜'
        #   else
        #     temp_row << '♖'
        #   end
        # end
            # p @board[[i, j]].class
          case @board[[i, j]].class.to_s
          when "Rook"
            # if [i, j] == start_color
            #   temp_row << ""

            if @board[[i, j]].color == :black
              temp_row << '♜ '
            else
              temp_row << '♖ '
            end
          when "Knight"
              if @board[[i, j]].color == :black
                temp_row << '♞ '
              else
                temp_row << '♘ '
              end
          when "Bishop"
            if @board[[i, j]].color == :black
              temp_row << '♝ '
            else
              temp_row << '♗ '
            end
          when "Queen"
            if @board[[i, j]].color == :black
              temp_row << '♛ '
            else
              temp_row << '♕ '
            end
          when "King"
            if @board[[i, j]].color == :black
              temp_row << '♚ '
            else
              temp_row << '♔ '
            end
          when "Pawn"
            if @board[[i, j]].color == :black
              temp_row << '♟ '
            else
              temp_row << '♙ '
            end
          when "NullPiece"
            temp_row << "e "
          end

        end
        # p temp_row
      end
      p temp_row
    end
    # @board.board.each do |row|
    #   temp_row = ""
    #   row.each do |piece|
    #     if piece.class == Piece
    #        temp_row << " P"
    #     else
    #       temp_row << " ▢"
    #     end
    #
    #   end
    #   p temp_row
    # end


  end



end
