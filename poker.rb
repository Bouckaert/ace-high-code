module Ably
  module CardProblem
    class Poker

      DECK = %w(2C 3C 4C 5C 6C 7C 8C 9C TC JC QC KC AC 2D 3D 4D 5D 6D 7D 8D 9D \
        TD JD QD KD AD 2H 3H 4H 5H 6H 7H 8H 9H TH JH QH KH AH 2S 3S 4S 5S 6S 7S\
         8S 9S TS JS QS KS AS)

      def give_cards
        player_hand = []
        5.times do
          hand << DECK[rand(DECK.size)]
          DECK.delete(hand.last)
        end

        player_hand
      end

      def hand
        Array.new(card_values)
      end

      def highest_card
        hand.sort.last[0]
      end

      def pair
        same_value == 2
      end

      def three?
        same_value == 3
      end

      def straight
        # Will return number of cards in sequence on player's hand
        sequence = 0

        hand.sort_by(&:to_i).each_with_index do |v,i|
          unless i == hand.count
            if hand[i+1] == hand[i].to_i + 1
              sequence += 1
            end
          end
        end
      end

      def same_value
        # Will return card's frequency on player's hand
        same_value = Hash[hand.group_by(&:itself).map {|k,v| [k, v.size] }]
      end

      def card_values
        value = String.new
        hand.each { |e| value += " #{e[0]}" }

        value.gsub(/[TJQKA]/, 'T' => 10, 'J' => '11', 'Q' => '12', 'K' => '13', 'A' => '14')
      end

      def straight?
        straight == 5
      end

      def flush?
        hand.select { |str| str.include?(hand.first[1]) } == 5
      end

      def full_house?
        three? && pair?
      end

      def four?
        same_value == 4
      end

      def straight_flush?
        straight? && flush?
      end

      def play(players)
        # For eache player give_cards and call above methods inside a case statement to identify the winner
      end
    end
  end
