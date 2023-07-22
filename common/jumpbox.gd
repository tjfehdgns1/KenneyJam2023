extends Area2D
class_name Jumpbox


signal bounce(object)

func _on_body_entered(player: Player) -> void:
	bounce.emit(player)
