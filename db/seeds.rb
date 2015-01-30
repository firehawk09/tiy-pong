# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

players = Player.all
Game.delete_all

list_of_games = PlayerMatch.create_matchups(players)
list_of_games.each do |game|
  Game.create(player1_id: game[0], player2_id: game[1], week: game[2] )
end
