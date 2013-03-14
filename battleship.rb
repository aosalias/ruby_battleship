require 'pp'
require_relative "ship.rb"

class Battleship
  attr_accessor :boards
  class DuplicateShotError < StandardError; end

  def initialize
    @turn = 1

    @player1_board = Array.new(10) { Array.new(10, "o") }
    @player2_board = Array.new(10) { Array.new(10, "o") }

    @player1_ships = []
    @player2_ships = []

    Ship::SHIPS.each_with_index do |length, index|
      @player1_ships << Ship.new(index, index, "v", length)
      @player2_ships << Ship.new(index, index, "v", length)
    end

    @boards = [@player1_board, @player2_board]
    @ships = [@player1_ships, @player2_ships]
  end

  def main
    while !over
      @turn += 1

      puts "Player #{(current_player + 1)}'s Turn"

      print_board

      begin
        puts "Please Enter Coordinates (x,y)"

        coords = gets
        x, y = *coords.split(",").map{|coord| Integer coord }

        mark_board(x,y)
      rescue Battleship::DuplicateShotError, ArgumentError, TypeError
        puts "Invalid Input, Try Again"
        retry
      end

      print_board
    end

    puts "Player #{current_player + 1} Won"
  end

  def print_board
    pp current_board
  end

  def mark_board(x, y)
    raise DuplicateShotError unless current_board[x][y] == "o"

    hit = current_ships.any? { |ship| ship.hit(x,y) }

    current_board[x][y] = hit ? "!" : "x"
  end

  def current_board
    @boards[current_player]
  end

  def current_ships
    @ships[current_player]
  end

  def current_player
    @turn%2
  end

  def over
    current_ships.all?(&:sunk?)
  end
end

if __FILE__ == $0
  Battleship.new.main
end


