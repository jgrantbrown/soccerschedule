class SoccerSchedule::Players
  attr_accessor :name,:position, :team
@@all =[]
def initialize(name, position)
  @name = name
  @position = position
  @team = team
  @@all<<self
end

def self.all
  @@all
end

def self.find_by_position(input)
  self.all.select { |player| player.position == input }   
end

end
