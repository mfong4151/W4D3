require_relative "board"



b = Board.new()
#b.render

b.move_piece([1,0], [3, 0])


b.move_piece([3,0], [4, 0])



b.move_piece([0,0], [2,0])
b.render



