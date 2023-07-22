extends BaseState



@export var run_node : NodePath
@export var idle_node : NodePath
@export var jump_node : NodePath

@onready var run_state: BaseState = get_node(run_node)
@onready var idle_state: BaseState = get_node(idle_node)
@onready var jump_state: BaseState = get_node(jump_node)

@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer


func enter() -> void:
	super()
	coyote_timer.start()


func unhandled_input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer.start()
		
		# coyote jump
		if !player.has_jumped and coyote_timer.time_left > 0.0:
			return jump_state
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
	apply_gravity(delta)
	player.move_and_slide()
	
	if player.is_on_floor():
		if move != 0:
			return run_state
		else:
			return idle_state
		if jump_buffer_timer.time_left > 0.0:
			return jump_state
	
#	else:
#		#! enemy step jump, not good 
#		if player.velocity.y < -10:
#			return jump_state
	return null


func exit() -> void:
	player.has_jumped = false


func apply_gravity(delta):
	if player.velocity.y > player.limit_gravity : return
	player.velocity.y += player.fall_gravity * delta
	
