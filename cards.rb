class Card
  attr_reader :value, :suit

  def initialize
    @value = rand(13)
    @suit = rand(4)
  end

  def to_s(hidden=false)
    if (hidden)
      "Xx"
    else
      values = %w(K A 2 3 4 5 6 7 8 9 T J Q)
      suits = %w(c d h s)
      "#{values[@value]}#{suits[@suit]}"
    end
  end

  def value
    values = [10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10]
    return values[@value]
  end

  # for the array include? method in class Cards
  def ==(other)
    return @value == other.value && @suit == other.suit
  end
end

class Cards
  @@all_cards = []

  def self.clear
    @@all_cards.clear
  end

  def initialize
    @cards = []
  end

  def deal_one
    # avoid getting a card that's exactly the same as one already been generated
    begin
      card = Card.new
    end while @@all_cards.include?(card)
    @@all_cards << card
    @cards << card
  end

  def deal_two
    deal_one
    deal_one
  end

  def to_s(hidden=false)
    string = ""
    @cards.each do |card|
      string << "#{card.to_s(hidden)} "
      hidden = false
    end
    return string
  end

  def value
    ace_dealt = false
    sum = 0
    @cards.each do |card|
      if (card.value == 1)
        ace_dealt = true
      end
      sum += card.value
    end

    # recalculate sum if an Ace was dealt
    if ace_dealt
      if sum <= 11
        sum += 10
      end
    end

    return sum
  end
end
