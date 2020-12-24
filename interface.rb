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

      player_turn
      @game.dealer_turn

      player_score, dealer_score = @game.end_game
      show_winner(player_score, dealer_score)

      puts 'Желаете играть дальше? (y/n)'
      answer = gets.chomp
      break if answer == 'n'
    end
  end

  def ask_name
    print 'Введите ваше имя: '
    gets.chomp
  end

  def player_turn
    puts 'Ваши карты:'
    @game.player.print_cards

    puts 'Ваше действие?'
    puts '1 - Пропустить ход'
    puts '2 - Взять карту'
    puts '3 - Открыть карты'
    action = gets.chomp.to_i
    make_action(action)
  end

  def show_winner(player_score, dealer_score)
    puts 'Ваши карты:'
    @game.player.print_cards

    puts 'Карты дилера:'
    @game.dealer.print_cards

    if player_score == dealer_score || (dealer_score > 21 && player_score > 21)
      puts "Ничья! Игрок = #{player_score}, дилер = #{dealer_score}"
      @game.player.get_money_back
      @game.dealer.get_money_back
      return
    end

    if player_score < 22 && (player_score > dealer_score || dealer_score > 21)
      puts "Победил игрок со счётом #{player_score}!"
      @game.player.add_win_to_bank
      return
    end

    if dealer_score < 22 && (dealer_score > player_score || player_score > 21)
      puts "Победил дилер со счётом #{dealer_score}!"
      @game.dealer.add_win_to_bank
      nil
    end
  end

  def make_action(action)
    case action
    when 1
      puts 'Вы выбрали пропустить ход'
    when 2
      puts 'Вы выбрали взять ещё одну карту'
      @game.player_take_card
      @game.print_statuses
    when 3
      puts 'Вы выбрали открыть карты'
    else
      raise 'Неизвестное действие'
    end
  end
end
