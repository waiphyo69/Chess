require_relative 'piece.rb'
require_relative 'slidingpiece.rb'
require_relative 'steppingpiece.rb'
require_relative 'pawn.rb'
require_relative 'board.rb'
require 'colorize'


COLUMN = {
           "A" => 0,
           "B" => 1,
           "C" => 2,
           "D" => 3,
           "E" => 4,
           "F" => 5,
           "G" => 6,
           "H" => 7
         }

class Game

  attr_accessor :board, :current_team

  def initialize
    @board = Board.new
    @current_team = 1
  end

  def play

    loop do
      board.display
      chosen_piece = choose_piece(current_team)
      chosen_pos = choose_pos(chosen_piece)
      redo if chosen_pos == "regret"
      move(chosen_piece, chosen_pos)
      if board.checkmate?(current_team)
        prints "Team #{current_team} Lose"
        break
      else
        self.current_team = ( self.current_team == 1 ? 2 : 1 )
      end
    end

  end

  def choose_piece(team)

    loop do

      print "Player #{current_team}, please choose the position of the piece you want to move (Ex: A1): "
      start_pos = gets.chomp.strip.split("")
      if start_pos.empty? || !COLUMN.keys.include?(start_pos[0]) || start_pos.size > 2
        puts "Not a valid input format, please choose again."
        redo
      end
      start_pos[0], start_pos[1] = start_pos[1].to_i - 1, COLUMN[start_pos[0]].to_i
      if board[start_pos].nil? || (board.in_board?(start_pos) && board[start_pos].team != team)
        puts "Invalid start position. Please choose again!"
      elsif board.in_board?(start_pos) && board[start_pos].team == team
        return board[start_pos]
      end

    end

  end

  def choose_pos(piece)

    loop do

      print "Please type in the position you want to move (row, col) or \'q\' to choose another piece: "
      end_pos = gets.chomp.strip.split("")
      return end_pos = "regret" if end_pos.map(&:downcase)[0] == 'q'  #/q+/
      if end_pos.empty? || !COLUMN.keys.include?(end_pos[0]) || end_pos.size > 2
        puts "Not a valid input format, please choose again."
        redo
      end
      end_pos[0], end_pos[1] = end_pos[1].to_i - 1, COLUMN[end_pos[0]].to_i
      return end_pos if piece.safe_move.include?(end_pos)
      if piece.all_valid_moves.include?(end_pos)
        puts "This move will put you in check, please choose again!"
        redo
      else
        puts "Not a valid position, please choose again!"
      end

    end

  end

  def move(piece, new_pos)

    self.board[new_pos] = piece
    self.board[piece.pos] = nil
    piece.pos = new_pos

  end

end

puts "Game has been started. Player 1 is color blue. Player 2 is color red."
g = Game.new
g.play
