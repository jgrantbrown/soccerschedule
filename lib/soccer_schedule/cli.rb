class SoccerSchedule::CLI

  def call
    SoccerSchedule::Teams.scrape_teams
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

  def list_teams
    @teams = SoccerSchedule::Teams.all
    @teams.each.with_index(1)  do |teams,i|
       puts "#{i}. #{teams.name}"
    end
  end

  def start
    list_teams
    team_input=nil
    @teams = SoccerSchedule::Teams.all
      while team_input != "exit"
        puts "Please select a team by number, 'list' for teams, or 'exit'"
        team_input = gets.strip.downcase
        if (1...@teams.length).include?(team_input.to_i)
            puts "More info about the #{@teams[team_input.to_i].name}"
            SoccerSchedule::Teams.team_schedule(team_input)
            # puts "#{@teams[team_input.to_i - 1].name}  info:"
            # puts " 1. Next Game "
            # puts " 2. Roster"
            # puts " 3. List Teams "
            # puts " 4. Exit"
            # detail_input= gets.strip.downcase
            #   if detail_input.to_i == 1
            #     SoccerSchedule::Teams.team_schedule(team_input)
            #   elsif detail_input.to_i == 2
            #     puts "Here is the roster: COMING SOON!"
            #   elsif detail_input.to_i == 3
            #
            #   elsif detail_input.to_i == 3
            #
            #   end
        elsif team_input == "list"
           list_teams
        else
          puts "Not valid entry. Type list or exit"
        end
      end
  end

  def goodbye
    puts "Have fun watching the game!"
  end
end
