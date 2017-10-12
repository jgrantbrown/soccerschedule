class SoccerSchedule::CLI

  def call
    SoccerSchedule::Scrapers.scrape_teams
    puts "_______________________________________"
    puts "Welcome to Soccer Schedules"
    puts " "
    puts '  o__        o__     |   |\ '
    puts ' /|          /\      |   |X\ '
    puts ' / > o        <\     |   |XX\ '
    puts ''
    puts "Which team schedule do you want?"
    puts "_______________________________________"
      start
      goodbye
  end

  def start
    list_teams
    team_input = nil

      while team_input != "exit"
        puts "____________________________________________________________"
        puts "Please select a team by number, 'list' for teams, players, position, or 'exit'"
        puts "____________________________________________________________"
        team_input = gets.strip.downcase

        # if (1..SoccerSchedule::Teams.all.length).include?(team_input.to_i)
        if team_input.to_i.between?(1, SoccerSchedule::Teams.all.length)
            @team = SoccerSchedule::Teams.find_team(team_input)
            puts "_______________________________________"
            puts "| More info about the #{@team.name}"
            puts "|______________________________________"
            puts "| 1. Next Game "
            puts "| 2. Roster"
            puts "| 3. List Teams "
            puts "| 4. Exit"
            puts "|______________________________________"
            detail_input = gets.strip.downcase

          case
            when detail_input.to_i == 1
              @team.team_schedule
            when detail_input.to_i == 2
              puts "Here is the #{@team.name} roster:"
              @team.get_team_roster
            when detail_input.to_i == 3
              SoccerSchedule::Teams.list_teams
            when detail_input.to_i == 4
              break
          end
        elsif team_input == "players"
          list_players
        elsif team_input == "position"
          list_players_by_position

        elsif team_input == "list"
           SoccerSchedule::Teams.list_teams
        elsif team_input == "exit"
            puts "See you soon!"
            break
        else
          puts "******************************************************************************"
          puts "Not valid entry or no addtional information. "
          puts "Type list or exit"
          puts "******************************************************************************"
        end
      end
  end

  def list_teams
    SoccerSchedule::Teams.all.each.with_index(1)  do |team,i|
       puts "#{i}. #{team.name}"
    end
  end

  def list_players
    SoccerSchedule::Players.all.each.with_index(1)  do |player,i|
       puts "#{i}. #{player.name}"
    end
  end

  def list_players_by_position
    puts "What postion would you like to search players?"
    input = gets.strip

    players = SoccerSchedule::Players.find_by_position(input)
    
    puts "Here is a list of players that play #{input}:"
    players.each.with_index(1)  do |player,i|
      puts "#{i}. #{player.name}"
    end

  end



  def goodbye
    puts "Have fun watching the game!"
  end


end
