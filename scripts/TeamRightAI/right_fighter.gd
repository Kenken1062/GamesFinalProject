extends Unit

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

# ====================================================
# DO NOT MODIFY CODE BELOW.
# ONLY CALL THE FUNCTIONS WHEN NEEDED.
# Functions to call: 
# - sword_attack(target: Unit): Swings the fighter's sword at the given target that is 
# within a range of 40 pixels one time and deals 15 damage. The cooldown is 2.5 seconds.
# - cleave_attack(targets: Array[Unit]): Swings the fighter's sword in an arc at a
# group of enemy units and hits up to three enemies. The cooldown is 7 seconds.
# The distance a fighter can hit a target at is 40.0
# ====================================================
@export var attack_damage: float = 15.0
@export var cleave_damage: float = 15.0
@export var attack_cooldown: float = 2.5
@export var cleave_cooldown: float = 7.0
@export var attack_distance: float = 40.0
var sword_timer: Timer
var cleave_timer: Timer

# Create the timers for the ability cooldowns.
# You should not be calling this function, it is done for you.
func create_timers() -> void:
	# Sword attack timer.
	sword_timer = Timer.new()
	sword_timer.wait_time = attack_cooldown
	sword_timer.one_shot = true
	add_child(sword_timer)

	# Cleave timer.
	cleave_timer = Timer.new()
	cleave_timer.wait_time = cleave_cooldown
	cleave_timer.one_shot = true
	add_child(cleave_timer)

# Sword attack damages one enemy.
func sword_attack(target: Unit) -> void:
	if not sword_timer.is_stopped():
		return
		
	if not is_instance_valid(target) or target.is_dead:
		return
		
	if position.distance_to(target.position) > attack_distance:
		return
		
	target.take_damage(attack_damage)
	sword_timer.start()

# Cleave attack damages up to three enemies.
func cleave_attack(targets: Array[Unit]) -> void:
	if not cleave_timer.is_stopped():
		return
		
	var close_targets: int = 0
	for target in targets:
		if position.distance_to(target.position) <= attack_distance:
			close_targets += 1
		
	if close_targets == 0:
		return
		
	var hit_count = 0
	for target in targets:
		if hit_count >= 3:
			break
			
		if not is_instance_valid(target) or target.is_dead:
			continue
			
		target.take_damage(cleave_damage)
		hit_count += 1
		
	cleave_timer.start()
