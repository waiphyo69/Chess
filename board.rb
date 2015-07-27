class Board
  GRID_SIZE = 8

  attr_accessor :grid

  def initialize
    @grid = make_grid
  end


  def make_grid
    
    grid = Array.new(GRID_SIZE){ Array.new(GRID_SIZE) }

    [0, 7].each_with_index do |row, team|
        grid[row] = [
                      Bishop.new(self, [row, 0], (team + 1)),
                      Knight.new(self, [row, 1], (team + 1)),
                      Rook.new(self, [row, 2], (team + 1)),
                      Queen.new(self, [row, 3], (team + 1)),
                      King.new(self, [row, 4], (team + 1)),
                      Rook.new(self, [row, 5], (team + 1)),
                      Knight.new(self, [row, 6], (team + 1)),
                      Bishop.new(self, [row, 7], (team + 1))
                    ]
    end

    [1, 6].each_with_index do |row, team|
      GRID_SIZE.times do |col|
        grid[row][col] = Pawn.new(self, [row, col], (team + 1))
      end
    end

    grid

  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, el)
    @grid[pos[0]][pos[1]] = el
  end

  def in_board?(pos)
    pos.all?{|idx|idx.between?(0,7)}
  end

  def display

    display_str = grid.flatten.map{|el| (el.nil?) ? "-" : el.symbol }
    puts "  #{COLUMN.keys.join("     ")}"
    GRID_SIZE.times do |idx|
    puts "#{idx + 1} #{display_str[GRID_SIZE * idx ..(GRID_SIZE * idx + GRID_SIZE - 1)].join("     ")} #{idx + 1}"
    end
    puts "  #{COLUMN.keys.join("     ")}"

  end

  def in_check? (team)

    king_pos = (get_king(team)).pos
    (enemy_valid_moves(team)).include?(king_pos)

  end


  def enemy_valid_moves (team)

    all_enemy_moves = []
    grid.flatten.each do |el|
      next if el.nil? || el.team == team
      all_enemy_moves += el.all_valid_moves
    end
    all_enemy_moves.uniq

  end

  def team_valid_moves (team)

    all_team_moves = []
    grid.flatten.each do |el|
      next if el.nil? || el.team != team
      all_team_moves += el.safe_move
    end
    all_team_moves.uniq

  end

  def get_king (team)
    grid.flatten.select { |el| el.class == King && el.team == team }[0]
  end

  def deep_dup
    grid.map { |sub| sub.dup }
  end

  def checkmate?(team)
    in_check?(team) && team_valid_moves(team).empty?
  end

end
