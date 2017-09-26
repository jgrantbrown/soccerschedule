class SoccerSchedule::Rosters
  attr_accessor :team, :players

  # REFACTOR FOR BETTER PRACTICE
  def initialize(players=nil)
     @players = []
  end

  def self.players_list(input)

    @team =  SoccerSchedule::Rosters.get_team_roster(input)

    @team.roster.each.with_index(1) do |player,i|
       puts "#{i}. #{player.name}  POSITION: #{player.position}"
    end
  end

  # add ability to scrape for team rosters to be added to team object
  def self.get_team_roster(input)

       @team = self.find_team(input)

       if @team.name == "Los Angeles FC"
            @team.roster= "No team info yet"
       else
         SoccerSchedule::Scrapers.scrape_roster(input)
       end
       @team
  end

  def self.find_team(input)
    SoccerSchedule::Teams.all[input.to_i-1]
  end

end
