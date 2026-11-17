extends Area2D

@export var speed: float = 300.0
@export var damage: float = 15.0

var direction: Vector2
var team_id: int = 0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	# Move in a straight line.
	global_position += direction * speed * delta
	
	# Point the lightning bolt in its travel direction.
	rotation = direction.angle() + PI/2
	
	# Delete the lightning bolt once it leaves the visible screen.
	var screen_position = get_viewport().get_canvas_transform() * global_position
	var screen_rect = get_viewport_rect().grow(64.0)
	if not screen_rect.has_point(screen_position):
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	# Only damage enemy units.
	if body is Unit:
		if body.team_id == team_id:
			return
		
		if not body.is_dead:
			body.take_damage(damage)
		
		queue_free()
