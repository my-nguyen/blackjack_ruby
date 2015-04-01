require './cards'

class Sinner
  def initialize(name)
    @cards = Cards.new
    @cards.deal_two
    @name = name
  end

  def to_s(hidden=false)
    "#{@name.capitalize}'s Cards: #{@cards.to_s(hidden)}"
  end

  def stayed_at
    "#{@name} stayed at #{@cards.value}"
  end
end

class Player < Sinner
  attr_reader :cards, :total, :name

  def initialize(name, total, bet)
    super(name)
    @total = total
    @bet = bet
  end

  def subtract
    @total -= @bet
  end

  def add
    @total += @bet
  end

  def now_has
    "#{@name} now has #{@total}"
  end

  def wins
    "#{@name} wins!"
  end

  def loses
    "#{@name} loses."
  end

  def had
    "#{@name} had #{@cards.value}"
  end

  def deal()
    while true
      if @cards.value == 21
        @total += @bet
        puts("#{wins} #{@name} hit blackjack. #{now_has}")
        break
      else
        print("#{@name} has #{@cards.value}. What would #{@name} like to do? [H]it/[S]tay ")
        if (gets.chomp.downcase == "h")
          @cards.deal_one
          puts(to_s)
          if @cards.value > 21
            @total -= @bet
            puts("#{loses} It looks like #{@name} busted at #{@cards.value}. #{now_has}")
            break
          end
        else
          break
        end
      end
    end
  end
end


class Dealer < Sinner
  def initialize()
    super("dealer")
  end

  def deal(player)
    while true
      puts(to_s)
      if @cards.value == 21
        player.subtract
        puts("#{player.loses} It looks like the dealer hit blackjack. #{player.had}. #{player.now_has}")
        break
      elsif @cards.value >= 17
        if @cards.value > player.cards.value
          player.subtract
          puts("#{player.loses} #{player.stayed_at}, and the #{stayed_at}. #{player.now_has}")
        elsif @cards.value == player.cards.value
          puts("It's a tie! Both #{player.name} and the #{stayed_at}. #{player.now_has}.")
        else
          player.add
          puts("#{player.wins} #{player.stayed_at}, and the #{stayed_at}. #{player.now_has}")
        end
        break
      else
        print("Dealer has #{@cards.value} and will hit. ")
        gets
        @cards.deal_one
        if @cards.value > 21
          puts(to_s)
          player.add
          puts("#{player.wins} The dealer busted at #{@cards.value}. #{player.stayed_at}. #{player.now_has}")
          break
        end
      end
    end
  end
end
