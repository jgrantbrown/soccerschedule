class SoccerSchedule::Teams
 attr_accessor :name, :url, :schedule_url, :next_game


# REFACTOR FOR BETTER PRACTICE
 # @@all=[]
 #
 #  def initialize(name, url)
 #    @name= name
 #    @url = url
 #    @schedule_url = url
 #    @next_game = next_game
 #    @@all<<self
 #  end
 #
 #  def self.all
 #    @@all
 #  end
 #
 # def self.find(id)
 #   self.all[id-1]
 # end

#  def self.new_from_home(team)
#     self.new(
#       name,
#       url,
#       schedule_url
#       next_game)
# end



  def self.all
    teams=[]
    doc = Nokogiri::HTML(open("https://www.mlssoccer.com/"))
    doc.css("a.banner-club-logo").map do |team|
      name = team.attr("title")
      url=""

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
      teams<<{:name => name,:url => url, :schedule_url => "#{uri.to_s}schedule"}
    end

    teams
  end


   def self.team_schedule(input)
    @teams= self.all
    @team= @teams[input.to_i-1]
    if @team[:name] == "Los Angeles FC"
      @team[:next_game]= "No schedule yet"
    else
         doc = Nokogiri::HTML(open("#{@team[:schedule_url]}", :allow_redirections => :safe))
         date = doc.css("div.match_details.upcoming").text
         time = doc.css("div.match_header div.match_info").text
         team_1 = doc.css("li.last div.match_container div.club_container img.club_logo").attr("title").value
         team_2 = doc.css("li.last div.match_container div.club_container.clubtwo img.club_logo").attr("title").value
         location = doc.css("li.last div.match_footer div.match_info").text
         @team[:next_game]={ :date=>date,:time=>time,:team_1=>team_1, :team_2=>team_2,:location=>location}
         puts "**********************************************************************"
         puts "*** #{@team[:next_game][:team_1]} vs #{@team[:next_game][:team_2]}"
         puts "***    #{@team[:next_game][:date]} @ #{@team[:next_game][:time]}  "
         puts "***    Location: #{@team[:next_game][:location]}                  "
         puts "**********************************************************************"
         @team
       end
   end



end
