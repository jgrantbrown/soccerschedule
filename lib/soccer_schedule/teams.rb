class SoccerSchedule::Teams
 attr_accessor :name, :url, :schedule_url, :next_game, :roster, :roster_url
  # REFACTOR FOR BETTER PRACTICE
 @@all=[]

  def initialize(name=nil, url=nil, schedule_url=nil, roster_url=nil)
    @name= name
    @url = url
    @schedule_url = schedule_url
    @next_game = next_game
    @roster_url = roster_url
    @roster= roster
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
           doc = Nokogiri::HTML(open("#{@team.schedule_url}", :allow_redirections => :safe))
           date = doc.css("div.match_details.upcoming").text
           time = doc.css("div.match_header div.match_info").text
           team_1 = doc.css("li.last div.match_container div.club_container img.club_logo").attr("title").value
           team_2 = doc.css("li.last div.match_container div.club_container.clubtwo img.club_logo").attr("title").value
           location = doc.css("li.last div.match_footer div.match_info").text
           @team.next_game={ :date=>date,:time=>time,:team_1=>team_1, :team_2=>team_2,:location=>location}

           @team.game_info
      end
   end

   def self.scrape_teams

     doc = Nokogiri::HTML(open("https://www.mlssoccer.com/"))

     doc.css("a.banner-club-logo").map do |team|
       name = team.attr("title")
       url = ""
         # hard coded descrepency in url form mls page scrape and actual web address
         if  team.attr("href")== "http://www.portlandtimbers.com/"
           url = "http://www.timbers.com/"
         elsif team.attr("href")== "http://www.realsaltlake.com/"
           url = "http://www.rsl.com/"
         else
           url=team.attr("href")
         end
         # Option #1
        uri = URI.parse(url)
        uri.scheme = "https"
        uri.to_s
         #option #2
         # url.gsub('/http/','https')
        SoccerSchedule::Teams.new( name,url, "#{uri.to_s}schedule","#{uri.to_s}players")
     end
   end

   def self.find_team(input)
       self.all[input.to_i-1]
   end

   def game_info
     puts "**********************************************************************"
     puts "*** #{self.next_game[:team_1]} vs #{self.next_game[:team_2]}"
     puts "***    #{self.next_game[:date]} @ #{self.next_game[:time]}  "
     puts "***    Location: #{self.next_game[:location]}                  "
     puts "**********************************************************************"
  end


end
