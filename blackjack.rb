require './cards'

def players_turn(player, name, total, bet)
  while true
    if player.value == 21
      total += bet
      puts("#{name} wins! #{name} hit blackjack. #{name} now has #{total}")
      break
    else
      print("#{name} has #{player.value}. What would #{name} like to do? [(H)it/(S)tay] ")
      if (gets.chomp.downcase == "h")
        player.deal_one
        puts("#{name}'s Cards: #{player.to_s}")
        if player.value > 21
          total -= bet
          puts("#{name} loses. It looks like #{name} busted at #{player.value}. #{name} now has $#{total}")
          break
        end
      else
        break
      end
    end
  end
  return total
end


def dealers_turn(dealer, player, name, total, bet)
  while true
    puts("Dealer's Cards: #{dealer.to_s}")
    if dealer.value == 21
      total -= bet
      puts("#{name} loses. It looks like the dealer hit blackjack. #{name} had #{player.value}. #{name} now has #{total}")
      break
    elsif dealer.value >= 17
      if dealer.value > player.value
        total -= bet
        puts("#{name} loses. #{name} stayed at #{player.value}, and the dealer stayed at #{dealer.value}. #{name} now has #{total}")
      elsif dealer.value == player.value
        puts("It's a tie! Both #{name} and the dealer stayed at #{player.value}. #{name} now has #{total}.")
      else
        total += bet
        puts("#{name} wins! #{name} stayed at #{player.value}, and the dealer stayed at #{dealer.value}. #{name} now has #{total}")
      end
      break
    else
      print("Dealer has #{dealer.value} and will hit. ")
      gets
      dealer.deal_one
      if dealer.value > 21
        puts("Dealer's Cards: #{dealer.to_s}")
        total += bet
        puts("#{name} wins! The dealer busted at #{dealer.value}. #{name} stayed at #{player.value}. #{name} now has $#{total}")
        break
      end
    end
  end
  return total
end


print("What's your name? ")
name = gets.chomp
total = 500

begin
  puts("#{name} has $#{total}")
  print("Make a bet for this round: ")
  bet = gets.to_i

  Cards.clear
  dealer = Cards.new
  dealer.deal_two
  puts("Dealer's Cards: #{dealer.to_s(true)}")
  player = Cards.new
  player.deal_two
  puts("#{name}'s Cards: #{player.to_s}")

  total = players_turn(player, name, total, bet)
  if player.value < 21
    total = dealers_turn(dealer, player, name, total, bet)
  end

  print("Play again? [(Y)es/(N)o] ")
end while (gets.chomp.downcase == 'y')
