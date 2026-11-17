extends Node2D

const LEFT_FIGHTER = preload("res://scripts/TeamLeftAI/left_fighter.gd")
const RIGHT_FIGHTER = preload("res://scripts/TeamRightAI/right_fighter.gd")
const LEFT_AXE_THROWER = preload("res://scripts/TeamLeftAI/left_axe_thrower.gd")
const RIGHT_AXE_THROWER = preload("res://scripts/TeamRightAI/right_axe_thrower.gd")
const LEFT_WIZARD = preload("res://scripts/TeamLeftAI/left_wizard.gd")
const RIGHT_WIZARD = preload("res://scripts/TeamRightAI/right_wizard.gd")
const LEFT_HEALER = preload("res://scripts/TeamLeftAI/left_healer.gd")
const RIGHT_HEALER = preload("res://scripts/TeamRightAI/right_healer.gd")

@export var fighter_scene : PackedScene
@export var axe_thrower_scene : PackedScene
@export var wizard_scene : PackedScene
@export var healer_scene : PackedScene

@export var left_team_ai_scene: PackedScene
@export var right_team_ai_scene: PackedScene

const TEAM_LEFT_ID: int = 0
const TEAM_RIGHT_ID: int = 1

func _ready() -> void:
	spawn_team_left()
	spawn_team_right()
	start_team_ai()
	GameManager.start_match()

func spawn_team_left() -> void:
	# Spawn four fighters at the front.
	var y_coords: Array = [260, 300, 340, 380]
	
	for i in range(4):
		var fighter = fighter_scene.instantiate()
		fighter.set_script(LEFT_FIGHTER)
		fighter.get_node("Sprite2D").self_modulate = Color.ORANGE_RED
		fighter.position.x = 370
		fighter.position.y = y_coords[i]
		fighter.team_id = TEAM_LEFT_ID
		fighter.add_to_group("left fighter")
		GameManager.left_team_units.append(fighter)
		add_child(fighter)
		fighter.create_timers()
	
	# Spawn three axe throwers behind the fighters.
	y_coords = [284, 324, 364]
	for i in range(3):
		var axe_thrower = axe_thrower_scene.instantiate()
		axe_thrower.set_script(LEFT_AXE_THROWER)
		axe_thrower.get_node("Sprite2D").self_modulate = Color.ORANGE_RED
		axe_thrower.position.x = 300
		axe_thrower.position.y = y_coords[i]
		axe_thrower.team_id = TEAM_LEFT_ID
		axe_thrower.add_to_group("left axe_thrower")
		GameManager.left_team_units.append(axe_thrower)
		add_child(axe_thrower)
		axe_thrower.create_timers()
		axe_thrower.axe_scene = preload("res://scenes/axe.tscn")
	
	# Spawn two wizards behind the axe throwers.
	y_coords = [304, 344]
	for i in range(2):
		var wizard = wizard_scene.instantiate()
		wizard.set_script(LEFT_WIZARD)
		wizard.get_node("Sprite2D").self_modulate = Color.ORANGE_RED
		wizard.position.x = 230
		wizard.position.y = y_coords[i]
		wizard.team_id = TEAM_LEFT_ID
		wizard.add_to_group("left wizard")
		GameManager.left_team_units.append(wizard)
		add_child(wizard)
		wizard.create_timers()
		wizard.lightning_scene = preload("res://scenes/lightning_bolt.tscn")
		wizard.fireball_scene = preload("res://scenes/fireball.tscn")
	
	# Spawn one healer in the back of the group.
	var healer = healer_scene.instantiate()
	healer.set_script(LEFT_HEALER)
	healer.get_node("Sprite2D").self_modulate = Color.ORANGE_RED
	healer.position.x = 160
	healer.position.y = 324
	healer.team_id = TEAM_LEFT_ID
	healer.add_to_group("left healer")
	GameManager.left_team_units.append(healer)
	add_child(healer)
	healer.create_timers()

func spawn_team_right() -> void:
	# Spawn four fighters at the front.
	var y_coords: Array = [260, 300, 340, 380]
	
	for i in range(4):
		var fighter = fighter_scene.instantiate()
		fighter.scale.x = -1
		fighter.set_script(RIGHT_FIGHTER)
		fighter.get_node("Sprite2D").self_modulate = Color.CORNFLOWER_BLUE
		fighter.position.x = 770
		fighter.position.y = y_coords[i]
		fighter.team_id = TEAM_RIGHT_ID
		fighter.add_to_group("right fighter")
		GameManager.right_team_units.append(fighter)
		add_child(fighter)
		fighter.create_timers()
	
	# Spawn three axe throwers behind the fighters.
	y_coords = [284, 324, 364]
	for i in range(3):
		var axe_thrower = axe_thrower_scene.instantiate()
		axe_thrower.scale.x = -1
		axe_thrower.set_script(RIGHT_AXE_THROWER)
		axe_thrower.get_node("Sprite2D").self_modulate = Color.CORNFLOWER_BLUE
		axe_thrower.position.x = 840
		axe_thrower.position.y = y_coords[i]
		axe_thrower.team_id = TEAM_RIGHT_ID
		axe_thrower.add_to_group("right axe_thrower")
		GameManager.right_team_units.append(axe_thrower)
		add_child(axe_thrower)
		axe_thrower.create_timers()
		axe_thrower.axe_scene = preload("res://scenes/axe.tscn")
	
	# Spawn two wizards behind the axe throwers.
	y_coords = [304, 344]
	for i in range(2):
		var wizard = wizard_scene.instantiate()
		wizard.scale.x = -1
		wizard.set_script(RIGHT_WIZARD)
		wizard.get_node("Sprite2D").self_modulate = Color.CORNFLOWER_BLUE
		wizard.position.x = 910
		wizard.position.y = y_coords[i]
		wizard.team_id = TEAM_RIGHT_ID
		wizard.add_to_group("right wizard")
		GameManager.right_team_units.append(wizard)
		add_child(wizard)
		wizard.create_timers()
		wizard.lightning_scene = preload("res://scenes/lightning_bolt.tscn")
		wizard.fireball_scene = preload("res://scenes/fireball.tscn")
	
	# Spawn one healer in the back of the group.
	var healer = healer_scene.instantiate()
	healer.scale.x = -1
	healer.set_script(RIGHT_HEALER)
	healer.get_node("Sprite2D").self_modulate = Color.CORNFLOWER_BLUE
	healer.position.x = 980
	healer.position.y = 324
	healer.team_id = TEAM_RIGHT_ID
	healer.add_to_group("right healer")
	GameManager.right_team_units.append(healer)
	add_child(healer)
	healer.create_timers()

func start_team_ai() -> void:
	var left_ai = left_team_ai_scene.instantiate()
	left_ai.setup(TEAM_LEFT_ID, GameManager.left_team_units)
	add_child(left_ai)
	
	for unit in GameManager.left_team_units:
		unit.team_ai = left_ai
	
	var right_ai = right_team_ai_scene.instantiate()
	right_ai.setup(TEAM_RIGHT_ID, GameManager.right_team_units)
	add_child(right_ai)
	
	for unit in GameManager.right_team_units:
		unit.team_ai = right_ai
