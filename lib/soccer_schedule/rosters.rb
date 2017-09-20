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
                  SoccerSchedule::Rosters.new(players.uniq)

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

 # url structure for rosters: https://www.fcdallas.com/players

 # team has a rosters
 # roster has many players
 # players belong to a team through rosters
 # player belongs to roster


#  SAmple player from site
 # <ul class="player_list list-reset"><li class="row first"><a href="/players/32/rj-allen" class="row_link"></a><div class="rounded_image_container"><a href="/players/32/rj-allen"><img class="rounded_image" src="https://newyorkcity-mp7static.mlsdigital.net/styles/image_player_headshot_small/s3/allen_0.jpg?JGo.I16CF8LUjLsaC1MsT5qXKCZnLZRJ&amp;itok=-yENTImv" width="88" height="125" alt="RJ Allen" title="RJ Allen"></a></div><div class="player_info"><div class="name"><a href="/players/32/rj-allen" class="name_link" data-name_link="Allen">RJ Allen</a></div><span class="jersey" data-jersey="27">27</span>
 # <span class="position">Defender</span><div class="stats_container"><div class="birthdate"><span class="category">Age:</span>
 # <span class="stat age" data-age="27">27</span></div>
 # <span class="category">HT:</span>
 # <span class="stat height" data-height="72">6 0</span>
 # <span class="category">WT:</span>
 # <span class="stat weight" data-weight="177">177</span>
 # </div></div><a href="/players/32/rj-allen"><i class="fa fa-angle-right fa_mp7"></i></a><a href="/players/32/rj-allen" class="button small_button view_more">View More</a></li>
