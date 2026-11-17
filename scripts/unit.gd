extends CharacterBody2D
class_name Unit

@onready var health_bar: ProgressBar = $HealthBar
@export var max_health: float = 100.0

# Variables you may need to use.
@export var team_ai: Node
@export var team_id: int = 0 # Team Left is 0, team Right is 1.
const MOVEMENT_SPEED: float = 100.0
var is_dead: bool = false
var current_health: float = 100.0

# Returns true if the given unit is an enemy of the current character.
# Else, returns false.
func is_enemy(other: Unit) -> bool:
	return team_id != other.team_id

# Returns true if the given unit is an ally of the current character.
# Else, returns false.
func is_ally(other: Unit) -> bool:
	return team_id == other.team_id

# ====================================================
# DO NOT CALL ANY OF THE FUNCTIONS BELOW.
# ====================================================
func take_damage(amount: float) -> void:
	current_health -= amount
	current_health = max(current_health, 0.0)
	health_bar.update_health(current_health, max_health)
	
	if current_health <= 0:
		die()

func heal(amount: float) -> void:
	current_health = min(current_health + amount, max_health)
	health_bar.update_health(current_health, max_health)

func die() -> void:
	if is_dead:
		return
	
	is_dead = true
	GameManager.remove_unit(self)
	queue_free()
