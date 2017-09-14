class SoccerSchedule::Rosters
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
