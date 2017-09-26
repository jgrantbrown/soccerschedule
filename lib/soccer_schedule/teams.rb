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

  def self.team_schedule(input)

    @team = self.find_team(input.to_i)

      if @team.name == "Los Angeles FC"
        @team.next_game= "No schedule yet"
      else
           SoccerSchedule::Scrapers.schedule_scrape(input)
      end
   end

  #  def self.scrape_teams
   #
  #    doc = Nokogiri::HTML(open("https://www.mlssoccer.com/"))
   #
  #    doc.css("a.banner-club-logo").map do |team|
  #      name = team.attr("title")
  #      url = ""
  #        # hard coded descrepency in url form mls page scrape and actual web address
  #        if  team.attr("href")== "http://www.portlandtimbers.com/"
  #          url = "http://www.timbers.com/"
  #        elsif team.attr("href")== "http://www.realsaltlake.com/"
  #          url = "http://www.rsl.com/"
  #        else
  #          url=team.attr("href")
  #        end
  #       uri = URI.parse(url)
  #       uri.scheme = "https"
  #       uri.to_s
  #       SoccerSchedule::Teams.new( name,url, "#{uri.to_s}schedule","#{uri.to_s}players")
  #    end
  #  end

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
    self.all.each.with_index(1)  do |teams,i|
       puts "#{i}. #{teams.name}"
    end
  end


end
