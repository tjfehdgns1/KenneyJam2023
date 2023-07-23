extends Camera2D

@export var target_path : NodePath
@onready var timer: Timer = $Timer



var shake := 0.0
var target


func _ready() -> void:
	Events.add_screenshake.connect(_start_screenshake)
	Events.camera_limits_changed.connect(_update_limit)
	
func _process(delta: float) -> void:
	offset.x = randf_range(-shake, shake)
	offset.y = randf_range(-shake, shake)

	
func _start_screenshake(amount, duration):
	shake = amount
	timer.start(duration)

func _update_limit(left, right, top, bottom):
	limit_left = left
	limit_right =right
	limit_top = top
	limit_bottom = bottom


func _on_timer_timeout() -> void:
	shake = 0
