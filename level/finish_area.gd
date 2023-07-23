extends Area2D




func _on_body_entered(player : Player) -> void:
	get_tree().change_scene_to_file("res://ui/finish_menu.tscn")
