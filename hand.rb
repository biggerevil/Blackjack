# frozen_string_literal: true

require_relative 'card'

class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def add_card(new_card)
    @cards.push(new_card)
  end

  def clear
    @cards = []
  end

  def count_cards_score
    total = 0

    # puts "@cards = #{@cards}"

    @cards.each do |card|
      name = card.name
      case name
      when /^\d{1,2}$/
        total += name.to_i
      when /[jqk]/i
        total += 10
      else
        total += 10 if total < 12
        total += 1
      end
    end
    total
  end
end
