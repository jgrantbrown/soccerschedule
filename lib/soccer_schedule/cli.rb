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
    team_input = nil

      while team_input != "exit"
        puts "Please select a team by number, 'list' for teams, or 'exit'"
        team_input = gets.strip.downcase
        @team = SoccerSchedule::Teams.find_team(team_input)

        if (1...SoccerSchedule::Teams.all.length).include?(team_input.to_i)
            puts "***************************************"
            puts "More info about the #{@team.name}"
            puts " 1. Next Game "
            puts " 2. Roster"
            puts " 3. List Teams "
            puts " 4. Exit"
            puts "***************************************"
            detail_input = gets.strip.downcase

          case
            when detail_input.to_i == 1
              @team.team_schedule
            when detail_input.to_i == 2
              puts "Here is the #{@team.name} roster:"
              SoccerSchedule::Teams.get_team_roster(@team)
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
          puts "******************************************************************************"
          puts "Not valid entry or no addtional information. "
          puts "Type list or exit"
          puts "******************************************************************************"
        end
      end
  end

  def goodbye
    puts "Have fun watching the game!"
  end
end
