extends Unit

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

# ====================================================
# DO NOT MODIFY CODE BELOW.
# ONLY CALL THE FUNCTIONS WHEN NEEDED.
# Functions to call: 
# - single_throw(direction: Vector2): Throws a single axe for 10 damage at the given direction. 
# The axe goes until it either hits an enemy or goes off the screen. The cooldown is 2 seconds.
# - cone_throw(direction: Vector2): Throws three axes for 10 damage each in a 25 degree cone at a given 
# direction. The axes go until they either hit an enemy or go off the screen. The cooldown is 6 seconds.
# ====================================================
@export var axe_scene: PackedScene

@export var attack_cooldown: float = 3.0
@export var special_cooldown: float = 6.0
@export var cone_angle: float = 25.0
var attack_timer: Timer
var special_timer: Timer

# Create the timers for the ability cooldowns.
# You should not be calling this function, it is done for you.
func create_timers() -> void:
	# Single throw attack timer.
	attack_timer = Timer.new()
	attack_timer.wait_time = attack_cooldown
	attack_timer.one_shot = true
	add_child(attack_timer)

	# Cone throw attack timer.
	special_timer = Timer.new()
	special_timer.wait_time = special_cooldown
	special_timer.one_shot = true
	add_child(special_timer)

# Throws one axe directly in a given direction.
func single_throw(direction: Vector2) -> void:
	if not attack_timer.is_stopped():
		return
		
	throw_axe(direction)
	
	attack_timer.start()

# Throws three axes in a cone at a given direction.
func cone_throw(direction: Vector2) -> void:
	if not special_timer.is_stopped():
		return
	
	var angle = deg_to_rad(cone_angle)
	
	# Center axe.
	throw_axe(direction)
	
	# Upper axe.
	throw_axe(direction.rotated(-angle))
	
	# Lower axe.
	throw_axe(direction.rotated(angle))
	
	special_timer.start()

# Spawn an axe projectile.
func throw_axe(direction: Vector2) -> void:
	var axe = axe_scene.instantiate()
	axe.team_id = team_id
	axe.direction = direction.normalized()
	
	get_tree().current_scene.add_child(axe)
	axe.global_position = global_position
