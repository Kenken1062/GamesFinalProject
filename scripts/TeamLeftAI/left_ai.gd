extends Node

var team_id: int
var team_units: Array[Unit] = []

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

# ====================================================
# DO NOT CALL OR MODIFY CODE BELOW.
# ====================================================
func setup(new_team_id: int, units: Array[Unit]) -> void:
	team_id = new_team_id
	team_units = units
