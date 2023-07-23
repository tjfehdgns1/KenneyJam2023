extends RigidBody2D





@export var speed := 100.0




@onready var stats: Stats = $Stats
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Area2D = $Hitbox
@onready var floor_cast: RayCast2D = $FloorCast


const DIE_EFFECT_SCENE := preload("res://effect/die_effect.tscn")







func _physics_process(delta: float) -> void:
	
	pass












func create_die_effect():
	Utils.instantiate_scene_on_world(DIE_EFFECT_SCENE, global_position)




func _on_stats_health_empty() -> void:
	Sounds.play(Sounds.die,1.5)
	animation_player.play("die")



func _on_hurtbox_hurt(damage) -> void:
	stats.health -= damage
	


func _on_jumpbox_bounce(object: Player) -> void:
	if not object is Player: return
	if object.velocity.y > 0:
		hitbox.monitoring = false
		object.velocity.y = object.jump_velocity
		stats.health -= 10
		Events.add_screenshake.emit(1,0.3)
