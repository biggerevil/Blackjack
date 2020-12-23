# frozen_string_literal: true

require_relative 'hand'
require_relative 'card'

class User
  attr_reader :name, :bank, :hand

  def initialize(name)
    @name = name
    @bank = 100
    @hand = Hand.new
  end

  def make_stake
    @bank -= 10
  end

  def add_win_to_bank
    @bank += 20
  end

  def get_money_back
    @bank += 10
  end

  def take_card(table)
    hand.cards.push(table.take_card)
  end

  def print_cards
    @hand.cards.each do |card|
      puts "#{card.name}, #{card.suit}"
    end
    puts
  end
end
