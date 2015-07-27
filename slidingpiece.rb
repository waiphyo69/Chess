# encoding: utf-8
class SlidingPiece < Piece

  def valid_moves(dir)

    new_board = Board.new
    new_board.grid = self.board.deep_dup
    self_dup = SlidingPiece.new(new_board, pos.dup, team)
    check_pos = pos[0] + dir[0], pos[1] + dir[1]

    if !board.in_board?(check_pos) || (!board[check_pos].nil? && team == board[check_pos].team)
      return [[]]
    end

    self_dup.pos = check_pos
    valid_moves_arr = [check_pos] + self_dup.valid_moves(dir)

  end

end

class Rook < SlidingPiece

  attr_reader :symbol

  def symbol
    team_color = super
    '♖'.colorize(team_color)
  end

  def move_dirs
    [
     [ 0,  1],
     [ 0, -1],
     [ 1,  0],
     [-1,  0]
    ]
  end

end

class Bishop < SlidingPiece

  attr_reader :symbol

  def symbol

    team_color = super
    '♗'.colorize(team_color)

  end

  def move_dirs

    [
     [ 1,  1],
     [ 1, -1],
     [-1,  1],
     [-1, -1]
    ]

  end

end

class Queen < SlidingPiece

  attr_reader :symbol

  def symbol

    team_color = super
    '♕'.colorize(team_color)

  end

  def move_dirs

    [
     [ 0,  1],
     [ 0, -1],
     [ 1,  0],
     [-1,  0],
     [ 1,  1],
     [ 1, -1],
     [-1,  1],
     [-1, -1]
    ]
    
  end

end
