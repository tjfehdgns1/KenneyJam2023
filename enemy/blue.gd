extends Node2D


@onready var stats: Stats = $Stats


const DIE_EFFECT_SCENE := preload("res://effect/die_effect.tscn")




func _on_jumpbox_body_entered(player: Player) -> void:
	if not player is Player: return
	if player.velocity.y > 0:
		player.velocity.y = player.jump_velocity
		stats.health -= 10


func _on_stats_health_empty() -> void:
	Utils.instantiate_scene_on_world(DIE_EFFECT_SCENE, global_position)
	Sounds.play(Sounds.die)
	queue_free()


func _on_hurtbox_hurt(damage) -> void:
	stats.health -= damage
	
