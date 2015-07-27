class Piece

  attr_reader :board, :team
  attr_accessor :pos

  def initialize(board, pos, team)
    @board, @pos, @team = board, pos, team
  end

  def symbol
    team_color = (team == 1 ? :blue : :red)
  end

  def safe_move

    safe_moves = []

    self.all_valid_moves.each do |new_pos|
      new_board = Board.new
      new_board.grid = board.deep_dup
      new_board[new_pos] = self
      new_board[self.pos] = nil
      safe_moves << new_pos unless new_board.in_check?(team)
    end

    safe_moves

  end

  def all_valid_moves

    result = []

     self.move_dirs.each do |dir|
       result.concat(valid_moves(dir))
     end

     result.select{|el|!el.empty?}
  end

end
