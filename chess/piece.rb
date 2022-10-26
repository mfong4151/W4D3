#require_relative 'board'
require 'singleton'

module Slideable
  def move(pos)

    move_dirs(pos)
    
  end

  def has_piece?(pos)
    return self.board[pos[0]][pos[1]] != "_"
  
  end

  def diagonal(pos)
    i, j = pos
    moves = [[1,1],[-1,1],[1,-1],[-1,-1]]
    diags = []

  
    moves.each do |y, x|
      7.times do |k|
        k = k + 1
        new_i = i + y*k
        new_j = j+ x*k
        break if self.has_piece?([new_i,new_j])
        if new_i.between?(0, 7) && new_j.between?(0, 7) && !diags.include?([new_i, new_j])
          diags << [new_i, new_j] 
        end
      end
    end

    diags

  end

  def straight(pos)
    i, j = pos
    moves = [[1,0],[-1,0],[0,-1],[0,1]]
    straights = []

  
    moves.each do |y, x|
      7.times do |k|
        k = k + 1
        new_i = i + y*k
        new_j = j+ x*k
        break if self.has_piece?([new_i,new_j])
        if new_i.between?(0, 7) && new_j.between?(0, 7) && !straights.include?([new_i, new_j])
          straights << [new_i, new_j] 
        end
      end
    end

    straights
  end

  def move_dirs(pos)

    if @board[pos] == :B
      diagonal(pos)
    elsif @board[pos] == :R
      straight(pos)
    elsif @board[pos] == :Q
      straight(pos) + diagonal(pos)
    end

  end

end

module Stepable

  def has_piece?(pos)
    return self.board[pos[0]][pos[1]] != "_"

  end
  
  def move(pos)
    move_dirs
  end

  def knight_move(pos)
    i, j = pos
    moves = [[2,1],[1,2],[-2,1],[1,-2], [-1,-2], [-2,-1], [2,-1], [-1,2]]
    knight = []

  
    moves.each do |y, x|
    
      
        new_i = i + y
        new_j = j+ x
      
        if new_i.between?(0, 7) && new_j.between?(0, 7) && !knight.include?([new_i, new_j]) && !self.has_piece?([new_i,new_j])
          knight << [new_i, new_j] 
        end
      
    end
      knight
  end

  def king_move(pos)
    i, j = pos
    moves = [[1,0],[-1,0],[0,-1],[0,1], [1,1],[-1,1],[1,-1],[-1,-1]]
    straights = []

  
    moves.each do |y, x|
      
        new_i = i + y
        new_j = j+ x
      
        if new_i.between?(0, 7) && new_j.between?(0, 7) && !straights.include?([new_i, new_j]) && !self.has_piece?([new_i,new_j])
          straights << [new_i, new_j] 
        end
    
    end

    straights
 
  end

  def move_dirs
    if @board[pos] == :N
      knight_move(pos)
      
    end
  end

end


class Piece
  ##superclass
  attr_accessor :board, :pos, :color, :symbol 
  def initialize(color, board, pos, symbol)
    @symbol = symbol
    @board = board
    @color = color
    @pos = pos
  end

  def to_s
  end

  def empty?
    @board[@pos].empty?
  end

  def symbol
    
  end

  private
  def move_into_check?(end_pos)

  end

end

class Rook < Piece

  include Slideable

  def valid_moves?(end_pos)
    move_dirs(self.pos).include?(end_pos)
  end

  private

  def move_dirs(pos)
    super(pos)
  end
end


class Queen < Piece

  include Slideable

  def valid_moves?(end_pos)
    move_dirs(self.pos).include?(end_pos)
  end

  private

  def move_dirs(pos)
    super(pos)
  end
end


class Bishop < Piece

  include Slideable

  def valid_moves?(end_pos)
    move_dirs(self.pos).include?(end_pos)
  end

  private

  def move_dirs(pos)
    super(pos)
  end
end


class Knight < Piece

  include Stepable

  def valid_moves?(end_pos)
    move_dirs(self.pos).include?(end_pos)
  end

  protected
  def move_dirs(pos)
    super(pos)
  end

end

class King < Piece

  include Stepable

  def valid_moves?(end_pos)
    move_dirs(self.pos).include?(end_pos)
  end

  protected
  def move_dirs(pos)
    super(pos)
  end

end


class NullPiece < Piece
  
  
  include Singleton


  def initialize
    @color = nil
    @symbol = '_'

  end


  def moves

  end

end


class Pawn < Piece

  
end

