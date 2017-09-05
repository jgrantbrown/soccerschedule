class SoccerSchedule::Teams
 attr_accessor :name, :url


def self.all
  teams=[]
  doc = Nokogiri::HTML(open("https://www.mlssoccer.com/"))
  doc.css("a.banner-club-logo").map do |team|
    name = team.attr("title")
    url = team.attr("href")
    teams<< {:name => name,:url => url}
  end
  teams
end

def self.team_schedule
  @teams= self.all
  teams_schedule=[]


  doc = Nokogiri::HTML(open("https://www.mlssoccer.com/"))
  doc.css("a.banner-club-logo").map do |team|
    name = team.attr("title")
    url = team.attr("href")
    teams<< {:name => name,:url => url}
  end
  teams
end


end
