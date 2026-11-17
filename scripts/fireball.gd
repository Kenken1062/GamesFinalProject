extends Area2D

@export var speed: float = 250.0
@export var damage: float = 20.0
@export var explosion_radius: float = 50.0

var direction: Vector2
var team_id: int = 0

# Variables for the explosion circle visual.
var explosion_duration: float = 0.6
var show_explosion: bool = false
var explosion_elapsed: float = 0.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	# Move in a straight line.
	global_position += direction * speed * delta
	
	# Point the fireball in its travel direction.
	rotation = direction.angle() + PI/2
	
	# Delete the fireball once it leaves the visible screen.
	var screen_position := get_viewport().get_canvas_transform() * global_position
	var screen_rect := get_viewport_rect().grow(64.0)
	if not screen_rect.has_point(screen_position):
		queue_free()

func _process(delta: float) -> void:
	if show_explosion:
		explosion_elapsed += delta
		
		if explosion_elapsed >= explosion_duration:
			queue_free()
			return
			
		queue_redraw()

func _draw() -> void:
	if not show_explosion:
		return
		
	# Transparent orange fill.
	draw_circle(Vector2.ZERO, explosion_radius, Color(1.0, 0.35, 0.05, 0.5))

func _on_body_entered(body: Node2D) -> void:
	# Only damage enemy units.
	if body is Unit:
		if body.team_id == team_id:
			return
		
		if body.is_dead:
			return
		
		# Explode when hitting an enemy.
		explode()

func explode() -> void:
	var enemies: Array = []
	
	# Get the enemy team's units.
	if team_id == 0:
		enemies = GameManager.right_team_units
	else:
		enemies = GameManager.left_team_units
	
	# Damage every enemy within the explosion radius.
	for enemy in enemies:
		if not is_instance_valid(enemy) or enemy.is_dead:
			continue
		
		var distance = position.distance_to(enemy.position)
		
		if distance <= explosion_radius:
			enemy.take_damage(damage)
	
	# Display explosion visual.
	show_explosion = true
	set_physics_process(false)
	$Sprite2D.hide()
	queue_redraw()
