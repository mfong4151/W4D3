
  def self.generate_pieces(board)
    

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
            board[pos[0]][pos[1]] = Rook.new(nil, board, pos, :R)

          elsif board[pos[0]][pos[1]] == :N
            board[pos[0]][pos[1]] = Knight.new(nil, board, pos, :N)

          elsif board[pos[0]][pos[1]] == :B
            board[pos[0]][pos[1]] = Bishop.new(nil, board, pos, :B)
          
          elsif board[pos[0]][pos[1]] == :Q
            board[pos[0]][pos[1]] = Queen.new(nil, board, pos, :Q)

          elsif board[pos[0]][pos[1]] == :K
            board[pos[0]][pos[1]] = King.new(nil, board, pos, :K)
          
          elsif board[pos[0]][pos[1]] == '_'

            board[pos[0]][pos[1]]= NullPiece.instance

          elsif board[pos[0]][pos[1]] == :P

           board[pos[0]][pos[1]] = Pawn.new(nil, board, pos, :P)

          end
          
      end
    end

    #defaults.each do |row|
    #  if row == 0 || row == 1
    #    elsif row == 6 || row == 7
    #    board[row].each{|el| el.color = black}
    #  end 
    #end

    (0...board.length).each do |i|
      (0...board.length).each do |j|
        if i == 0 || i == 1
          board[i][j].color = 'white'
        
        end
      end
    end


    board
  end