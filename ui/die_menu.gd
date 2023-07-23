extends Control


@onready var restart_button: Button = %RestartButton
@onready var quit_button: Button = %QuitButton


func _ready() -> void:
	restart_button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_button_pressed() -> void:
	PlayerStats.health = PlayerStats.max_health
	get_tree().change_scene_to_file("res://world.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/start_menu.tscn")
