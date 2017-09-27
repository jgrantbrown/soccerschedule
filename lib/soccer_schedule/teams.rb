class SoccerSchedule::Teams
 attr_accessor :name, :schedule_url, :next_game, :roster, :roster_url
  # REFACTOR FOR BETTER PRACTICE
 @@all=[]

  def initialize(name = nil, schedule_url = nil, roster_url = nil)
    @name= name

    @schedule_url = schedule_url
    @next_game = next_game
    @roster_url = roster_url
    @roster = []
    @@all<<self
  end

  def self.all
    @@all
  end

  def team_schedule
      if self.name == "Los Angeles FC"
        self.next_game = "No schedule yet"
      else
        SoccerSchedule::Scrapers.schedule_scrape(self)
      end
   end

   def self.find_team(input)
       self.all[input.to_i-1]
   end

   def game_info
     puts "**********************************************************************"
     puts "***    #{self.next_game[:team_1]} vs #{self.next_game[:team_2]}"
     puts "***    #{self.next_game[:date]} @ #{self.next_game[:time]}  "
     puts "***    Location: #{self.next_game[:location]}                  "
     puts "**********************************************************************"
  end

  def self.list_teams
    self.all.each.with_index(1)  do |team,i|
       puts "#{i}. #{team.name}"
    end
  end

  def self.get_team_roster(team)
       if team.name == "Los Angeles FC"
          team.roster = "No team info yet"
       else
         SoccerSchedule::Scrapers.scrape_roster(team)
       end
    team.roster.each.with_index(1) do |player,i|
         puts "------------------------------------------------------"
         puts "#{i}. #{player.name}  POSITION: #{player.position}"

    end
  end

end
