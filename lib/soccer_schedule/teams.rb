class SoccerSchedule::Teams
 attr_accessor :name, :url


def self.all
  teams=[]
  teams_url=[]
  # div banner-club-container
  # attr("href")
  # banner-logo title= team-name
  doc = Nokogiri::HTML(open("https://www.mlssoccer.com/"))

  doc.css("a.banner-club-logo").map do |each|
    teams<<each.attr("title")
    teams_url<< each.attr("href")
  end
  # team_name = doc.search("a.banner-club-logo").first.attr("title")
  # team_url = doc.search("a.banner-club-logo").first.attr("href")
  # puts "1. Redbulls"
  # puts "2. NYCFC"
  # puts "3. DC United"
  puts teams

  # teams<<
end




end
