
require "./bin/mastermind.rb"

print 'Player1 enter your name: '
input = gets.chomp
new_game = Game.new(input)
new_game.start
