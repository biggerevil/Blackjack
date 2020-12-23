# frozen_string_literal: true

require_relative 'player'
require_relative 'dealer'
require_relative 'table'

class Game
  attr_reader :player, :dealer, :table, :players

  def initialize(name)
    @player = Player.new(name)
    @dealer = Dealer.new('Дилер')
    @table = Table.new
    @players = [@player, @dealer]
  end

  def start_game
    make_stakes!
    @players.each do |player|
      2.times do
        player.take_card(@table)
      end
    end
  end

  def take_card(player)
    player.take_card(@table)
  end

  def make_action(action)
    case action
    when 1
      puts 'Вы выбрали пропустить ход'
    when 2
      puts 'Вы выбрали взять ещё одну карту'
      @player.take_card(@table)
      print_statuses
    when 3
      puts 'Вы выбрали открыть карты'
    else
      raise 'Неизвестное действие'
    end
  end

  def player_turn
    puts 'Ваши карты:'
    @player.print_cards

    puts 'Ваше действие?'
    puts '1 - Пропустить ход'
    puts '2 - Взять карту'
    puts '3 - Открыть карты'
    action = gets.chomp.to_i
    make_action(action)
  end

  def dealer_turn
    @dealer.take_turn(@table)
  end

  def print_statuses
    @players.each do |player|
      puts "#{player.name} имеет карты:"
      if player.name != 'Дилер'
        player.print_cards
        puts 'Суммка очков:'
        puts player.hand.count_cards_score
      else
        puts '*' * player.hand.cards.length
        puts 'Сумма очков дилера:'
        puts player.hand.count_cards_score
      end
      puts "И #{player.bank}$ в банке"
      puts
    end
  end

  def end_game
    player_score = @player.hand.count_cards_score
    dealer_score = @dealer.hand.count_cards_score

    print_statuses

    @table.bank = 0
    @table.reload_cards
    @players.each { |player| player.hand.clear }

    show_winner(player_score, dealer_score)
  end

  def show_winner(player_score, dealer_score)
    puts 'Ваши карты:'
    player.print_cards

    puts 'Карты дилера:'
    dealer.print_cards

    if player_score == dealer_score || (dealer_score > 21 && player_score > 21)
      puts "Ничья! Игрок = #{player_score}, дилер = #{dealer_score}"
      player.get_money_back
      dealer.get_money_back
      return
    end

    if player_score < 22 && (player_score > dealer_score || dealer_score > 21)
      puts "Победил игрок со счётом #{player_score}!"
      dealer.add_win_to_bank
      return
    end

    if dealer_score < 22 && (dealer_score > player_score || player_score > 21)
      puts "Победил дилер со счётом #{dealer_score}!"
      dealer.add_win_to_bank
      nil
    end
  end

  def make_stakes!
    raise 'У кого-то нет денег!' unless @players.all? { |player| player.bank > 10 }

    @players.each(&:make_stake)
    @table.bank += 10 * @players.length
  end
end
