class SoccerSchedule::Rosters

# add ability to scrape for team rosters to be added to team object
  def self.team_roster(input)
   @teams= self.all
   @team= @teams[input.to_i-1]
   if @team[:name] == "Los Angeles FC"
     @team[:team_roster]= "No team info yet"
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
