class SoccerSchedule::CLI

  def call
    SoccerSchedule::Scrapers.scrape_teams
    puts "Welcome to Soccer Schedules"
    puts " "
    puts '  o__        o__     |   |\ '
    puts ' /|          /\      |   |X\ '
    puts ' / > o        <\     |   |XX\ '
    puts ''
    puts "Which team schedule do you want?"
      start
      goodbye
  end

  def start
    SoccerSchedule::Teams.list_teams
    team_input=nil
    @teams = SoccerSchedule::Teams.all

      while team_input != "exit"
        puts "Please select a team by number, 'list' for teams, or 'exit'"
        team_input = gets.strip.downcase
        # @team = SoccerSchedule::Teams.find_team(team_input.to_i)
        if (1...@teams.length).include?(team_input.to_i)
            puts "More info about the #{@teams[team_input.to_i-1].name}"
            puts " 1. Next Game "
            puts " 2. Roster"
            puts " 3. List Teams "
            puts " 4. Exit"
            detail_input= gets.strip.downcase
                case
              when detail_input.to_i == 1
                SoccerSchedule::Teams.team_schedule(team_input)
              when detail_input.to_i == 2
                puts "Here is the roster:"
                SoccerSchedule::Rosters.players_list(team_input.to_i)
              when detail_input.to_i == 3
                SoccerSchedule::Teams.list_teams
              when detail_input.to_i == 4
                break
              end
        elsif team_input == "list"
           SoccerSchedule::Teams.list_teams
        elsif team_input == "exit"
            puts "See you soon!"
            break
        else
          puts "Not valid entry. Type list or exit"
        end
      end
  end

  def goodbye
    puts "Have fun watching the game!"
  end
end
