# frozen_string_literal: true

require_relative 'user'

class Dealer < User
  def take_turn(table)
    take_card(table) if hand.count_cards_score < 17
  end
end
