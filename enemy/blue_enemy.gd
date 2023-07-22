extends RigidBody2D


@onready var stats: Stats = $Stats
@onready var animation_player: AnimationPlayer = $AnimationPlayer


const DIE_EFFECT_SCENE := preload("res://effect/die_effect.tscn")



func _on_stats_health_empty() -> void:
	Utils.instantiate_scene_on_world(DIE_EFFECT_SCENE, global_position)
	Sounds.play(Sounds.die)
	queue_free()


func _on_hurtbox_hurt(damage) -> void:
	stats.health -= damage
	


func _on_jumpbox_bounce(object: Player) -> void:
	if not object is Player: return
	if object.velocity.y > 0:
		object.velocity.y = object.jump_velocity
		stats.health -= 10
