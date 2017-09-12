class SoccerSchedule::CLI

  def call
    puts "Welcome to Soccer Schedules"
    puts " "
    puts '  o__        o__     |   |\ '
    puts ' /|          /\      |   |X\ '
    puts ' / > o        <\     |   |XX\ '
    puts ''
    puts "Which team schedule do you want?"
      list_teams
      menu
      goodbye
  end

  def list_teams
    @teams = SoccerSchedule::Teams.all
    @teams.each.with_index(1)  do |teams,i|
       puts "#{i}. #{teams[:name]}"
    end
  end

  def menu
    input=nil
    @teams = SoccerSchedule::Teams.all
    @schedule= SoccerSchedule::Teams.team_schedule(input)
      while input != "exit"
        puts "Please select a team by number, 'list' for teams, or 'exit'"
        input = gets.strip.downcase
        if (1...@teams.length).include?(input.to_i)
            puts "#{@teams[input.to_i - 1][:name]} next game info:"
            SoccerSchedule::Teams.team_schedule(input)
          menu
        elsif input == "list"
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
