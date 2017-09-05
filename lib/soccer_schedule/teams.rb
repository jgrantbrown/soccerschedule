class SoccerSchedule::Teams
 attr_accessor :name, :url
def self.all
  teams=[]
  # div banner-club-container
  # attr("href")
  # banner-logo title= team-name
  doc = Nokogiri::HTML("https://www.mlssoccer.com/")
  doc.search("div banner-club-container")

  puts "1. Redbulls"
  puts "2. NYCFC"
  puts "3. DC United"

  # teams<<
end




end
