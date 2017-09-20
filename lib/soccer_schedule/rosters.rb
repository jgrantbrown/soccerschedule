class SoccerSchedule::Rosters
  attr_accessor :team, :players

  # REFACTOR FOR BETTER PRACTICE
  @@all=[]

   def initialize(players=nil)
     @players = []
     @@all<<self
   end
# add ability to scrape for team rosters to be added to team object
  def self.team_roster(input)
     @teams= SoccerSchedule::Teams.all
     @team= @teams[input.to_i-1]

           if @team.name == "Los Angeles FC"
             @team.roster= "No team info yet"
           else
              players=[]
              doc = Nokogiri::HTML(open("#{@team.roster_url}", :allow_redirections => :safe))

              doc.css("ul.player_list li.row div.player_info").map do |plyr_name|
                  fullname = plyr_name.css("div.name a.name_link").text
                  position = plyr_name.css("span.position").text
                    # THis is grouping all names?
                  add_player = SoccerSchedule::Players.new(fullname,position)
                  add_player.team=@team.name
                  players<<add_player
                  @team.roster=players
                end
            end
    end

def self.players(input)
  SoccerSchedule::Rosters.team_roster(input)
  @teams= SoccerSchedule::Teams.all
  @team= @teams[input.to_i-1]
   @team.roster.each do |player|
     puts "#{player.name}  POSITION: #{player.position}"
  end
end

end

><a href="/players/32/rj-allen"><i class="fa fa-angle-right fa_mp7"></i></a><a href="/players/32/rj-allen" class="button small_button view_more">View More</a></li>
