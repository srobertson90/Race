require_relative('race.rb')

class Modifier

def initialize (modifiers=nil)
  if modifiers == nil
    @modifiers = {}
    (15).times do
      @modifiers[rand(1..30)] = rand(-1..1)
    end
  else
    @modifiers = modifiers
  end
end

def adjustment(energy)
  @modifiers[energy]

end

end