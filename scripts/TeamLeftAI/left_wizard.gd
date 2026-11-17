extends Unit

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

# ====================================================
# DO NOT MODIFY CODE BELOW.
# ONLY CALL THE FUNCTIONS WHEN NEEDED.
# Functions to call: 
# - lightning_attack(direction: Vector2): Shoots a single lightning bolt that does 15 damage at 
# the given direction. The lightning bolt goes until it either hits an enemy or goes off the screen. 
# The cooldown is 2 seconds.
# - fireball_attack(direction: Vector2): Shoots a fireball at the given direction. The fireball 
# goes until it either hits an enemy or goes off the screen. If the fireball hits an enemy, it 
# explodes and does 20 damage to all enemies within 50 pixel radius. The cooldown is 8 seconds.
# ====================================================
@export var lightning_scene: PackedScene
@export var fireball_scene: PackedScene

@export var lightning_range: float = 400.0
@export var lightning_cooldown: float = 2.0
@export var fireball_range: float = 400.0
@export var fireball_cooldown: float = 8.0
var lightning_timer: Timer
var fireball_timer: Timer

# Create the timers for the ability cooldowns.
# You should not be calling this function, it is done for you.
func create_timers() -> void:
	# Lightning cooldown.
	lightning_timer = Timer.new()
	lightning_timer.wait_time = lightning_cooldown
	lightning_timer.one_shot = true
	add_child(lightning_timer)
	
	# Fireball cooldown.
	fireball_timer = Timer.new()
	fireball_timer.wait_time = fireball_cooldown
	fireball_timer.one_shot = true
	add_child(fireball_timer)

# Shoot a lightning bolt at the nearest enemy.
func lightning_attack(direction: Vector2) -> void:
	if not lightning_timer.is_stopped():
		return
	
	var lightning = lightning_scene.instantiate()
	lightning.team_id = team_id
	lightning.direction = direction
	
	get_tree().current_scene.add_child(lightning)
	lightning.global_position = global_position
	
	lightning_timer.start()

# Shoot a fireball at the nearest enemy.
func fireball_attack(direction: Vector2) -> void:
	if not fireball_timer.is_stopped():
		return
	
	var fireball = fireball_scene.instantiate()
	fireball.team_id = team_id
	fireball.direction = direction
	
	get_tree().current_scene.add_child(fireball)
	fireball.position = position
	
	fireball_timer.start()
