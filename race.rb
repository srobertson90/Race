class Race

  attr_reader :athletes_array 

  def initialize(athlete_1_name, athlete_2_name, modifier=nil)
    @athletes_array = [
      {name:athlete_1_name, position:0, energy:5},
      {name:athlete_2_name, position:0, energy:5}
    ]
    @current_athlete_index = 0
    @modifier = modifier
  end

  def move_athlete(athlete_index, distance)
    athlete = @athletes_array[athlete_index]
    athlete[:position] += distance
    athlete[:energy] -= 1
    return athlete
  end

  def remove_energy_from_athlete(athlete_index, energy)
    athlete = @athletes_array[athlete_index]
    athlete[:energy] += energy
    # return athlete
  end

  def current_athlete()
    return athletes_array[@current_athlete_index]
  end

  def change_current_athlete()
    @current_athlete_index = (@current_athlete_index + 1) % @athletes_array.length
  end

  def move_current_athlete(distance)
    move_athlete(@current_athlete_index, distance)
  end

  def remove_energy_from_current_athlete(energy)
    remove_energy_from_athlete(@current_athlete_index, energy)
  end

  def play_turn(distance)
    turn_info = {
      athlete_name: current_athlete[:name],
      roll: distance
    }
    move_current_athlete(distance)
    
    if @modifier
      modified = @modifier.adjustment(current_athlete[:energy])
      remove_energy_from_current_athlete(modified) if modified
      turn_info[:adjustment] = modified
    end
    
    turn_info[:energy] = current_athlete[:energy]
    turn_info[:end_position] = current_athlete[:position]
    change_current_athlete()
    return turn_info
  end

  def winner
    if (athletes_array[0][:energy] == 0) && (athletes_array[1][:energy] == 0)
      if (athletes_array[0][:position].to_i > athletes_array[1][:position].to_i)
        return athletes_array[0]
      else
        return athletes_array[1]
      end
    else
     return false
   end

 end 

end