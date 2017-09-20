class SoccerSchedule::Rosters
  attr_accessor :team, :players

  # REFACTOR FOR BETTER PRACTICE


   def initialize(players=nil)
     @players = []

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
   @team.roster.each.with_index(1) do |player,i|
     puts "#{i}. #{player.name}  POSITION: #{player.position}"
  end
end

end
