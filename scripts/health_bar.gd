extends ProgressBar

func _ready() -> void:
	# Make the background dark.
	var background = StyleBoxFlat.new()
	background.bg_color = Color(0.0, 0.0, 0.0)
	add_theme_stylebox_override("background", background)
	
	# Make the filled portion green.
	var health = StyleBoxFlat.new()
	health.bg_color = Color.GREEN
	add_theme_stylebox_override("fill", health)

func update_health(current_health: float, max_health: float) -> void:
	max_value = max_health
	value = current_health
