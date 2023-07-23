extends Control


@onready var resume_button: Button = %ResumeButton
@onready var restart_button: Button = %RestartButton

var paused := false : set = set_pause


func set_pause(value):
	paused = value
	get_tree().paused = paused
	visible = paused
	

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		resume_button.grab_focus()
		paused = !paused
	


func _on_resume_button_pressed() -> void:
	paused = false


func _on_restart_button_pressed() -> void:
	paused = !paused
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/start_menu.tscn")
