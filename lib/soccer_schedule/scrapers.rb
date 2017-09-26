class SoccerSchedule::Scrapers

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
       uri = URI.parse(url)
       uri.scheme = "https"
       uri.to_s
       SoccerSchedule::Teams.new( name,url, "#{uri.to_s}schedule","#{uri.to_s}players")
    end
  end

  def self.scrape_roster(input)

    @team = SoccerSchedule::Rosters.find_team(input)
    doc = Nokogiri::HTML(open("#{@team.roster_url}", :allow_redirections => :safe))

    doc.css("ul.player_list li.row div.player_info").map do |plyr_name|
      fullname = plyr_name.css("div.name a.name_link").text
      position = plyr_name.css("span.position").text
      # THis is grouping all names?
      add_player = SoccerSchedule::Players.new(fullname,position)
      add_player.team=@team.name
      @team.roster ||= []
      @team.roster<<add_player
      @team.roster
    end
  end

  def self.schedule_scrape(team)
  

    doc = Nokogiri::HTML(open("#{team.schedule_url}", :allow_redirections => :safe))
    date = doc.css("div.match_details.upcoming").text
    time = doc.css("div.match_header div.match_info").text
    team_1 = doc.css("li.last div.match_container div.club_container img.club_logo").attr("title").value
    team_2 = doc.css("li.last div.match_container div.club_container.clubtwo img.club_logo").attr("title").value
    location = doc.css("li.last div.match_footer div.match_info").text
    team.next_game = { :date=>date,:time=>time,:team_1=>team_1, :team_2=>team_2,:location=>location}

    team.game_info
  end





end
