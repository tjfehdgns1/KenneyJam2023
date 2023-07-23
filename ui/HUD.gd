extends CanvasLayer

@onready var resource_label: Label = $ResourceLabel
@onready var color_rect: ColorRect = $ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.player_hurt.connect(_on_player_hurt)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	resource_label.text = str(PlayerStats.resource)


func _on_player_hurt():
	color_rect.show()
	await get_tree().create_timer(0.01).timeout
	color_rect.hide()
