# frozen_string_literal: true

require_relative 'game'

class Interface
  attr_reader :game

  def initialize
    # player_name = ask_name
    player_name = 'f'
    @game = Game.new(player_name)

    loop do
      @game.start_game

      @game.player_turn
      @game.dealer_turn

      @game.end_game

      puts 'Желаете играть дальше? (y/n)'
      answer = gets.chomp
      break if answer == 'n'
    end
  end

  def ask_name
    print 'Введите ваше имя: '
    gets.chomp
  end
end
