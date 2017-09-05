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
  end

def list_teams
  @teams = SoccerSchedule::Teams.all
end

def menu
  input=nil
  while input != "exit"
    puts "Please select a team by number, 'list' for teams, or 'exit'"
    input= gets.strip
    case input
    when "1"
      puts "found team 1"
    when "2"
      puts " found team 2"
    when "list"
    list_teams
  else
    puts "Not valid entry. Type list or exit"
  end
  end
end

end
