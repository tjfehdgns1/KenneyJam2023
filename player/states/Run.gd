extends BaseState


@export var jump_node : NodePath
@export var fall_node : NodePath
@export var idle_node : NodePath


@onready var jump_state : BaseState = get_node(jump_node)
@onready var fall_state : BaseState = get_node(fall_node)
@onready var idle_state : BaseState = get_node(idle_node)


const DUST_EFFECT_SCENE := preload("res://effect/dust_effect.tscn")


func enter():
	super()
	if PlayerStats.resource < PlayerStats.max_resource:
		PlayerStats.resource = PlayerStats.max_resource
		Sounds.play(Sounds.reload,1.0,-5.0)

func unhandled_input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("jump") and !player.has_jumped and player.velocity.y == 0:
		return jump_state
	return null


func physics_process(delta: float) -> BaseState:
	if !player.is_on_floor():
		return fall_state

	var move = get_movement_input()
	if move < 0:
		player.sprite_2d.flip_h = true
	elif move > 0:
		player.sprite_2d.flip_h = false
		
	if move > 0:
		player.sprite_2d.set_rotation_degrees(-3.0)
	elif move < 0:
		player.sprite_2d.set_rotation_degrees(3.0)
	else:
		player.sprite_2d.set_rotation_degrees(0.0)
	
	player.velocity.y += player.gravity * delta
	player.velocity.x = move_toward(player.velocity.x, move * player.move_speed, player.acceleration * delta)
	player.move_and_slide()
	
	if move == 0:
		return idle_state

	return null

func get_movement_input() -> int:
	if Input.is_action_pressed("move_left"):
		return -1
	elif Input.is_action_pressed("move_right"):
		return 1
	
	return 0


func creat_dust_effect():
	Sounds.play(Sounds.footstep, 1.0, -10.0)
	Utils.instantiate_scene_on_world(DUST_EFFECT_SCENE, player.global_position)
	
