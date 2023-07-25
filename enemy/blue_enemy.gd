extends CharacterBody2D




@export var turn_at_ledge := true
@export var speed := 100.0
@export var move_x := 1



@onready var stats: Stats = $Stats
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Area2D = $Hitbox
@onready var floor_cast: RayCast2D = $FloorCast
@onready var wall_cast: RayCast2D = $WallCast
@onready var blue_enemy: CharacterBody2D = $"."


const DIE_EFFECT_SCENE := preload("res://effect/die_effect.tscn")




func _ready() -> void:
	animation_player.play("run")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += 100 * delta
		
	if is_on_wall():
		turn_around()
		
	if is_at_ledge() and turn_at_ledge:
		turn_around()
		
	velocity.x = move_x * speed
	blue_enemy.scale.x = move_x

	move_and_slide()


func turn_around():
	move_x *= -1


func is_at_ledge():
	return is_on_floor() and !floor_cast.is_colliding()





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
