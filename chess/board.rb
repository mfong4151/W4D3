require_relative 'requirements'

class Board

include Slideable
include Stepable


  def self.generate_backrow(color, board, row)
    pieces = [Rook.new(color, board, [row, 0],:R),
              Knight.new(color, board, [row, 1], :N),
              Bishop.new(color, board, [row, 2],:B),
              Queen.new(color, board, [row, 3],:Q),
              King.new(color, board, [row, 4],:K),
              Bishop.new(color, board, [row, 5],:B),
              Knight.new(color, board, [row, 6],:N),
              Rook.new(color, board, [row, 7],:R)]
    pieces

  end

  def self.generate_pawns(color, board, row)

    pawns = Array.new(8){Pawn.new(color,board, row, :P)}
    
    pawns

  end

  def self.generate_null
    Array.new(8){NullPiece.instance}
  end
  
  def self.generate_pieces()
    white = 'white'
    black = 'black'
    board = []

    (0...8).each do |row|
      if row == 0 
        temp = Board.generate_backrow(black, board, row)
      elsif row == 1
        temp = Board.generate_pawns(black, board, row)

      elsif row == 6
        temp = Board.generate_pawns(white, board, row)

      elsif row == 7
        temp = Board.generate_backrow(white, board, row)

      else #null
        temp = Board.generate_null
      end
      board << temp
    end
    board 
  end


  attr_reader :board
  def initialize()
    #@board = Array.new(8){Array.new(8, '_')}
    @board = Board.generate_pieces()

  end

  def move_piece(start_pos, end_pos)
    x_start, y_start = start_pos
    x_end, y_end = end_pos

    if self[start_pos].symbol == '_'
      raise "There's no piece to move at this position"

    # elsif x_end.between?(0, 7) && y_end.between?(0, 7) 
    #   && x_start.between?(0, 7) && y_end.between(0, 7)
    else
      self[end_pos] = self[start_pos]
      self[start_pos] = NullPiece.instance

    end

  end

  def render
    @board.each do |row|
      row.each do |el|
        print ' ', el.symbol
      end
      puts
    end
  end

  def [](pos)
    @board[pos[0]][pos[1]]

  end

  def[]=(pos, val)
    @board[pos[0]][pos[1]] = val

  end
end