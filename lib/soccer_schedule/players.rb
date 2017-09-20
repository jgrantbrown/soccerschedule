class SoccerSchedule::Players
  attr_accessor :name,:position, :team

def initialize(name, position)
  @name = name
  @position = position
  @team =team
end

end
