# encoding: utf-8

class SteppingPiece < Piece

  def valid_moves(dir)

    check_pos = pos[0] + dir[0], pos[1] + dir[1]
    return [check_pos]if self.board.in_board?(check_pos)  && ( board[check_pos].nil? || board[check_pos].team != team)
    [[]]

  end

end

class Knight < SteppingPiece

  attr_reader :symbol

  def symbol

    team_color = super
    '♘'.colorize(team_color)

  end

  def move_dirs

    [
     [ 1,  2],
     [ 1, -2],
     [ 2,  1],
     [ 2, -1],
     [-1,  2],
     [-1, -2],
     [-2,  1],
     [-2, -1]
    ]

  end

end

class King < SteppingPiece

  attr_reader :symbol

  def symbol

    team_color = super
    '♔'.colorize(team_color)

  end

  def move_dirs

    [
     [ 0,  1],
     [ 0, -1],
     [ 1,  1],
     [ 1, -1],
     [ 1,  0],
     [-1,  0],
     [-1,  1],
     [-1, -1]
    ]
    
  end

end
