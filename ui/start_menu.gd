extends Control




@onready var start_button: Button = %StartButton


func _ready() -> void:
	start_button.grab_focus()



func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	PlayerStats.health = PlayerStats.max_health
	get_tree().change_scene_to_file("res://world.tscn")
	
