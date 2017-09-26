class SoccerSchedule::Teams
 attr_accessor :name, :url, :schedule_url, :next_game, :roster, :roster_url
  # REFACTOR FOR BETTER PRACTICE
 @@all=[]

  def initialize(name = nil, url = nil, schedule_url = nil, roster_url = nil)
    @name= name
    @url = url
    @schedule_url = schedule_url
    @next_game = next_game
    @roster_url = roster_url
    @roster = roster
    @@all<<self
  end

  def self.all
    @@all
  end

  def team_schedule
      if self.name == "Los Angeles FC"
        self.next_game= "No schedule yet"
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


end
