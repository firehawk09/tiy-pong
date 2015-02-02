class PlayerMatch

  #takes an array of players
  def self.create_matchups(players)
    player_arr = []
    players.each { |player| player_arr << player.id }
    # player_arr.shuffle!
    matchups = self.list_of_matchups(self.match_players(player_arr))
    self.attach_week_to_game(matchups, player_arr)
  end


  #returns a hash with each player login as the key and 10 other players in an array
  def self.match_players(players)
    matches = Hash.new([])
    players.each do |player|
      temp_player_remove = players.delete(player)
      matches[player] = players.sample(players.size)
      players << temp_player_remove
      players.sort!
    end
    matches
  end

  def self.list_of_matchups(matches)
    matchup_list = []
    matches.each do |player, opponents|
      opponents.each do |opponent|
        unless (matchup_list.include? [player, opponent]) ||
               (matchup_list.include? [opponent, player])
          matchup_list << [player, opponent]
        end
      end
    end
    matchup_list
  end

  #2 games per week and 3 on the last week
  def self.attach_week_to_game(matchup_list, player_arr)
    weeks = [1,1,2,2,3,3,4,4,5,5,5]
    player_match_weeks = {}
    player_arr.each do |player|
      player_match_weeks[player] = weeks.dup
    end

    matchup_list_with_week = []

    matchup_list.each do |matchup|
      break_me = false
      player1 = matchup[0]
      player2 = matchup[1]
      # find the first element in weeks that equal for both players
      p1_available_weeks = player_match_weeks[player1]
      p2_available_weeks = player_match_weeks[player2]

      (0..p1_available_weeks.size-1).each do |index|
        (0..p2_available_weeks.size-1).each do |index|
          if p1_available_weeks[index] == p2_available_weeks.first
            matchup_list_with_week << [player1, player2, p1_available_weeks[index]]
            p1_available_weeks.delete_at(index)
            p2_available_weeks.shift
            # binding.pry
            break_me = true
            break
          end
          break if break_me
        end
      end
    end
    matchup_list_with_week
  end

  def self.count_matches_per_player(matchup_list)
    match_count = Hash.new(0)
    matchup_list.each do |matchup|
      match_count[matchup[0]] += 1
      match_count[matchup[1]] += 1
    end
    match_count
  end
end


