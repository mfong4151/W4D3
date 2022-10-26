require_relative 'requirements'

class Board

include Slideable
include Stepable


  
  def self.generate_pieces(board)
    black = 'black'
    white = 'white'
    defaults = [0,1,6,7]
    pieces = [:R,:N, :B, :Q, :K,:B, :N, :R]
    pawns = [:P]*8


    defaults.each do |row|
      if row == 6 || row == 1
        board[row]= pawns
      else
        board[row] = pieces 
      end

    end


    (0...board.length).each do |i|
      (0...board[0].length).each do |j| 
          pos = [i,j]
          if board[pos[0]][pos[1]] == :R
            board[pos[0]][pos[1]] = Rook.new(black, board, pos, :R)

          elsif board[pos[0]][pos[1]] == :N
            board[pos[0]][pos[1]] = Knight.new(black, board, pos, :N)

          elsif board[pos[0]][pos[1]] == :B
            board[pos[0]][pos[1]] = Bishop.new(black, board, pos, :B)
          
          elsif board[pos[0]][pos[1]] == :Q
            board[pos[0]][pos[1]] = Queen.new(black, board, pos, :Q)

          elsif board[pos[0]][pos[1]] == :K
            board[pos[0]][pos[1]] = King.new(black, board, pos, :K)
          
          elsif board[pos[0]][pos[1]] == '_'

            board[pos[0]][pos[1]]= NullPiece.instance

          elsif board[pos[0]][pos[1]] == :P

           board[pos[0]][pos[1]] = Pawn.new(black, board, pos, :P)

          end
          
      end
    end

    defaults.each do |row|
      if row == 0 || row == 1
        elsif row == 6 || row == 7
        board[row].each{|el| el.color = black}
      end 
    end



    board
  end


  attr_reader :board
  def initialize()
    @board = Array.new(8){Array.new(8, '_')}
    @board = Board.generate_pieces(@board)

  end

  def move_piece(start_pos, end_pos)
    x_start, y_start = start_pos
    x_end, y_end = end_pos

    if self[start_pos] == '_'
      raise "There's no piece to move at this position"

    # elsif x_end.between?(0, 7) && y_end.between?(0, 7) 
    #   && x_start.between?(0, 7) && y_end.between(0, 7)
    else
      self[end_pos] = self[start_pos]
      self[start_pos] = '_'

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