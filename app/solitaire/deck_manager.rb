$gtk.reset

class DeckManager
  def initialize
    iniit_deck
    @discard = []
  end

  def shuffle_deck
    @deck = @discard.copy
    @discard.clear
  end

  def move_to_discard(cards)
    cards.each { |card| @discard << card }
  end

  def draw(n)
    raise "n must be positive" unless n > 0

    shuffle_deck if @deck.empty?

    drawn_count = [n, @deck.count].min

    take_n_from_deck(drawn_count)
  end

  private

  def iniit_deck
    suits = %w[club diamond heart spade]
    values = (2..10).map(&:to_s).push("J", "Q", "K", "A")

    combinations = []
    suits.each do |suit|
      values.each do |value|
        combinations << [suit, value]
      end
    end

    @deck = combinations.map {|arr| Card.new(arr.first, arr.last)}
  end

  def take_n_from_deck(n)
    drawn =[]

    n.times do
      drawn << take_from_deck
    end

    drawn
  end

  def take_from_deck
    card = @deck.sample
    @deck.delete(card)

    card
  end

end
