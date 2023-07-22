extends BaseState


@export var fall_node : NodePath
@export var run_node : NodePath
@export var idle_node : NodePath


@onready var fall_state : BaseState = get_node(fall_node)
@onready var run_state : BaseState = get_node(run_node)
@onready var idle_state : BaseState = get_node(idle_node)


const JUMP_EFFECT_SCENE := preload("res://effect/jump_effect.tscn")


func enter() -> void:
	super()
	player.velocity.y = player.jump_velocity
	player.has_jumped = true
	
	Utils.instantiate_scene_on_world(JUMP_EFFECT_SCENE, player.global_position)
	
	Sounds.play(Sounds.jump, 1.0, -10.0)

func unhandled_input(event: InputEvent) -> BaseState:
	# small jump
	if Input.is_action_just_released("jump") and player.velocity.y < player.jump_velocity / 2:
		player.velocity.y = player.jump_velocity / 2
		return fall_state
	return null

func physics_process(delta: float) -> BaseState:
	var move = 0
	if Input.is_action_pressed("move_left"):
		move = -1
		player.sprite_2d.flip_h = true
	elif Input.is_action_pressed("move_right"):
		move = 1
		player.sprite_2d.flip_h = false
		
	if move > 0:
		player.sprite_2d.set_rotation_degrees(-3.0)
	elif move < 0:
		player.sprite_2d.set_rotation_degrees(3.0)
	else:
		player.sprite_2d.set_rotation_degrees(0.0)
	
	player.velocity.x = move * player.air_speed
	player.velocity.y += player.gravity * delta
	player.move_and_slide()
	
	# fall
	if player.velocity.y > 0:
		return fall_state

	if player.is_on_floor():
		if move != 0:
			return run_state
		return idle_state
	return null
