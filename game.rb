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

  def player_take_card
    @player.take_card(@table)
  end

  def end_game
    player_score = @player.hand.count_cards_score
    dealer_score = @dealer.hand.count_cards_score

    print_statuses

    @table.bank = 0
    @table.reload_cards
    @players.each { |player| player.hand.clear }

    [player_score, dealer_score]
  end

  def make_stakes!
    raise 'У кого-то нет денег!' unless @players.all? { |player| player.bank > 10 }

    @players.each(&:make_stake)
    @table.bank += 10 * @players.length
  end
end
