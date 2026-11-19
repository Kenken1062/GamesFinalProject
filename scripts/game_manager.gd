extends Node

var left_team_units: Array[Unit] = []
var right_team_units: Array[Unit] = []
var match_started: bool = false
var match_over: bool = false

func _physics_process(_delta: float) -> void:
	if not match_started or match_over:
		return
		
	# Get the living units on each team.
	var left_alive = left_team_units.size()
	var right_alive = right_team_units.size()
	
	# Check game ending conditions.
	if left_alive == 0 and right_alive == 0:
		end_match(-1) # Draw.
	elif left_alive == 1 and right_alive == 1 \
	and left_team_units[0].is_in_group("left healer") \
	and right_team_units[0].is_in_group("right healer"):
		end_match(-1) # Draw.
	elif left_alive == 0:
		end_match(1) # Team Right wins.
	elif right_alive == 0:
		end_match(0) # Team Left wins.

func remove_unit(unit: Unit) -> void:
	if unit.team_id == 0:
		left_team_units.erase(unit)
	else:
		right_team_units.erase(unit)

func start_match() -> void:
	match_over = false
	match_started = true

func end_match(winning_team_id: int) -> void:
	match_over = true
	match_started = false
	
	print("Match finished!")
	
	if winning_team_id == -1:
		print("Draw!")
		get_tree().quit()
	elif winning_team_id == 1:
		print("Team Right wins!")
		get_tree().quit()
	else:
		print("Team Left wins!")
		get_tree().quit()
