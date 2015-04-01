require './player'

print("What's your name? ")
name = gets.chomp
total = 500

begin
  puts("#{name} has $#{total}")
  print("Make a bet for this round: ")
  bet = gets.to_i

  Cards.clear
  dealer = Dealer.new
  puts(dealer.to_s(true))
  player = Player.new(name, total, bet)
  puts(player.to_s)

  player.deal
  if player.cards.value < 21
    dealer.deal(player)
  end

  total = player.total
  print("Play again? [Y]es/[N]o ")
end while (gets.chomp.downcase == 'y')
