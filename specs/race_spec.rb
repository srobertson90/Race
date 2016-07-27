require ('minitest/autorun')
require ('minitest/rg')
require_relative ('../race.rb')
require_relative ('../modifiers.rb')

class TestRace < MiniTest::Test

  def setup
    @modifier_set = Modifier.new({5 => 1, 10 => -1})
    @short_race = Race.new("Jay", "Tony", @modifier_set)
  end

  def test_athletes_start_at_0
    assert_equal( [
      {name:"Jay", position: 0, energy:5}, 
      {name:"Tony", position: 0, energy:5}
      ], @short_race.athletes_array() )
  end

  def test_athletes_can_move
    @short_race.move_athlete(0, 5)
    assert_equal( 5, @short_race.current_athlete()[:position])
  end

  def test_can_remove_energy_from_current_athlete
      @short_race.remove_energy_from_current_athlete(3)
      assert_equal(8, @short_race.current_athlete[:energy])
  end

  def test_athlete_1_to_start
    assert_equal( "Jay", @short_race.current_athlete()[:name])
  end

  def test_can_change_current_athlete
    @short_race.change_current_athlete()
    assert_equal("Tony", @short_race.current_athlete()[:name])
  end

  def test_can_move_current_athlete
    @short_race.move_current_athlete(5)
    assert_equal(5, @short_race.current_athlete[:position])
  end

  def test_play_turn_changes_current_athlete
    @short_race.play_turn(5)
    assert_equal("Tony", @short_race.current_athlete[:name])
  end

  def test_play_turn_returns_turn_info
   turn_info = @short_race.play_turn(5)
   assert_equal({athlete_name: "Jay", roll: 5, adjustment: nil, energy: 4, end_position: 5}, turn_info)
  end

  def test_can_show_winner
  @short_race.athletes_array()[0][:energy] = 0
  @short_race.athletes_array()[0][:position] = 10
  @short_race.athletes_array()[1][:energy] = 0
  @short_race.athletes_array()[1][:position] = 5
  assert_equal({name: "Jay", position:10, energy:0}, @short_race.winner())
  end
 
  def test_shows_no_winner
  assert_equal(false, @short_race.winner())
  end

end