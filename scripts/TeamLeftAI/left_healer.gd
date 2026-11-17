extends Unit

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

# ====================================================
# DO NOT MODIFY CODE BELOW.
# ONLY CALL THE FUNCTIONS WHEN NEEDED.
# Functions to call: 
# - single_heal(target: Unit): Choose a single ally unit to heal for 10 health. The range for
# the single heal is 350 pixels from the healer. The cooldown is 3 seconds.
# - heal_group(): Heal all allies in a 90 pixel radius around the healer. All allies are healed
# for 20 health. The cooldown is 12 seconds. 
# ====================================================
@export var heal_amount: float = 10.0
@export var heal_range: float = 350.0
@export var heal_cooldown: float = 3.0
@export var special_heal_amount: float = 20.0
@export var special_heal_radius: float = 90.0
@export var special_heal_cooldown: float = 12.0
var heal_timer: Timer
var special_heal_timer: Timer

# Variables for the group healing circle visual.
var show_heal_radius: bool = false
var heal_radius_elapsed: float = 0.0
var heal_radius_duration: float = 0.6

# Variables for the single healing circle visual.
var show_single_heal: bool = false
var single_heal_target: Unit = null
var single_heal_elapsed: float = 0.0
var single_heal_duration: float = 0.6
var single_heal_radius: float = 20.0

func _process(delta: float) -> void:
	# Group heal circle.
	if show_heal_radius:
		heal_radius_elapsed += delta
		if heal_radius_elapsed >= heal_radius_duration:
			show_heal_radius = false
		queue_redraw()
		
	# Single heal circle.
	if show_single_heal:
		single_heal_elapsed += delta
		if single_heal_elapsed >= single_heal_duration:
			show_single_heal = false
			single_heal_target = null
		queue_redraw()

func _draw() -> void:
	# Group heal circle around healer.
	if show_heal_radius:
		draw_circle(Vector2.ZERO, special_heal_radius, Color(0.2, 1.0, 0.4, 0.5))
		
	# Single heal circle underneath the target.
	if show_single_heal and is_instance_valid(single_heal_target):
		var target_position = to_local(single_heal_target.position)
		draw_circle(target_position, single_heal_radius, Color(0.2, 1.0, 0.4, 0.5))

func create_timers() -> void:
	# Single healing timer.
	heal_timer = Timer.new()
	heal_timer.wait_time = heal_cooldown
	heal_timer.one_shot = true
	add_child(heal_timer)
	
	# Group healing timer.
	special_heal_timer = Timer.new()
	special_heal_timer.wait_time = special_heal_cooldown
	special_heal_timer.one_shot = true
	add_child(special_heal_timer)

# Heals one friendly unit.
func single_heal(target: Unit) -> void:
	if not heal_timer.is_stopped():
		return
	
	if not is_instance_valid(target) or target.is_dead:
		return
	
	if not is_ally(target):
		return
	
	if target.position.distance_to(position) > heal_range:
		return
	
	if target.current_health >= target.max_health:
		return
	
	target.heal(heal_amount)
	heal_timer.start()
	single_heal_target = target
	single_heal_elapsed = 0.0
	show_single_heal = true
	queue_redraw()

# Heals all friendly units within the radius.
func heal_group() -> void:
	if not special_heal_timer.is_stopped():
		return
	
	var allies: Array = []
	
	if team_id == 0:
		allies = GameManager.left_team_units
	else:
		allies = GameManager.right_team_units
	
	for ally in allies:
		if not is_instance_valid(ally) or ally.is_dead:
			continue
		
		if position.distance_to(ally.position) <= special_heal_radius:
			if ally.current_health < ally.max_health:
				ally.heal(special_heal_amount)
				
	special_heal_timer.start()
	show_heal_radius = true
	heal_radius_elapsed = 0.0
	queue_redraw()
