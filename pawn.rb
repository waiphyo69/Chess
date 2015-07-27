# encoding: utf-8

class Pawn < Piece
  
  attr_reader :symbol

  def symbol

    team_color = super
    '♙'.colorize(team_color)

  end

  def move_dirs

    [
     [ 1, 0],
     [-1, 0],
     [ 1, 1],
     [-1, 1]
    ]

  end

  def valid_moves(dir)

    result = []
    check_pos = pos[0] + dir[0], pos[1] + dir[1]

    if (dir == [1,0] && team == 1) || (dir == [-1,0] && team == 2)
      result << check_pos if self.board.in_board?(check_pos) && board[check_pos].nil?
    else
      result <<check_pos if self.board.in_board?(check_pos)  && ( !board[check_pos].nil?) && (board[check_pos].team != team)
    end

    result

  end

end
