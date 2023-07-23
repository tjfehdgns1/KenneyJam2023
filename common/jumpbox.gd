extends Area2D
class_name Jumpbox


signal bounce(object)

func _on_body_entered(player: Player) -> void:
	if PlayerStats.resource < PlayerStats.max_resource:
		PlayerStats.resource = PlayerStats.max_resource
		Sounds.play(Sounds.reload)
	bounce.emit(player)
