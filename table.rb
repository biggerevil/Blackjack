# frozen_string_literal: true

require_relative 'card'

class Table
  attr_reader :cards
  attr_accessor :bank

  Values = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  Suits = %w[diamonds clubs hearts spades].freeze

  def initialize
    reload_cards
    @bank = 0
  end

  def reload_cards
    @cards = []
    Suits.each do |suit|
      Values.each do |value|
        new_card = Card.new(value, suit)
        @cards.push(new_card)
      end
    end
  end

  def take_card
    random_number = rand(@cards.length)
    # taken_card = @cards.delete_at(random_number)
    # taken_card
    @cards.delete_at(random_number)
  end
end
