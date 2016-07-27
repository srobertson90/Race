require_relative('./race.rb')
require_relative('./modifiers.rb')

class RaceRunner

  def initialize(race)
    @race = race
  end

  def run_race
    puts "Run! The player that runs the furthest is the winner!"
    until @race.winner() do
      play_turn()
    end

    puts "#{@race.winner[:name]} wins the game. Woo!"
  end

  def play_turn
    puts "#{@race.current_athlete()[:name]}. Press Enter to roll dice."
    gets
    info = @race.play_turn(rand(1..6))
    show_turn_info(info)
  end

  def show_turn_info(turn_info)
    puts "#{turn_info[:athlete_name]} rolled a #{turn_info[:roll]}."
    puts "#{turn_info[:athlete_name]} has #{turn_info[:energy]} energy left."
    litter = turn_info[:adjustment]
    if (litter)
      if (litter > 0)
        puts "Nice you found a water bottle"
      elsif (litter < 0)
        puts "Oh no, tripped over a stone"
      end
    end
    puts "#{turn_info[:athlete_name]} now at position #{turn_info[:end_position]}"
    puts "\n"
  end

end

litter_hash = Modifier.new() 
race = Race.new("Jay", "Tony", litter_hash)
runner = RaceRunner.new(race)
runner.run_race()