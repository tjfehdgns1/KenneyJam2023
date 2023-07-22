extends CharacterBody2D
class_name Player


@export var move_speed := 100.0
@export var acceleration := 1000.0
@export var deceleration := 1300.0

@export var air_speed := 150.0
@export var peak_jump_time := 0.4
@export var descent_jump_time := 0.35
@export var jump_height := 80.0
@export var limit_gravity := 500.0
@export var coyote_time := 0.15
@onready var gravity = ((-2.0 * jump_height) / (peak_jump_time * peak_jump_time)) * -1.0
@onready var fall_gravity = ((-2.0 * jump_height) / (descent_jump_time * descent_jump_time)) * -1.0
@onready var jump_velocity = ((2.0 * jump_height) / (peak_jump_time)) * -1.0

var has_jumped := false



@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: Node = $StateMachine as StateMachine
@onready var sprite_2d: Sprite2D = $Sprite2D








func _ready() -> void:
	PlayerStats.health_empty.connect(_die)
	state_machine.init(self)
	
func _process(delta: float) -> void:
	state_machine.process(delta)

func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.unhandled_input(event)


func _die():
	queue_free()
