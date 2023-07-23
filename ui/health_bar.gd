extends Control


@onready var empty: TextureRect = $Empty
@onready var full: TextureRect = $Full





func _ready() -> void:
	max_health_ui()
	health_ui()
	PlayerStats.max_health_changed.connect(max_health_ui)
	PlayerStats.health_changed.connect(health_ui)
	
	
	
	
func health_ui():
	full.size.x = PlayerStats.health * 16
	
func max_health_ui():
	empty.size.x = PlayerStats.max_health * 16
	
