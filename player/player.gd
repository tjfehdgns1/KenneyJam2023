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
@onready var gravity = ((-2.0 * jump_height) / (peak_jump_time * peak_jump_time)) * -1.0
@onready var fall_gravity = ((-2.0 * jump_height) / (descent_jump_time * descent_jump_time)) * -1.0
@onready var jump_velocity = ((2.0 * jump_height) / (peak_jump_time)) * -1.0
var has_jumped := false

@export var jet_force := -200


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var override_animation_player: AnimationPlayer = $OverrideAnimationPlayer
@onready var state_machine: Node = $StateMachine as StateMachine
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var state_label: Label = $StateLabel
@onready var camera_2d: Camera2D = $Camera2D


const DIE_EFFECT_SCENE := preload("res://effect/die_effect.tscn")





func _ready() -> void:
	PlayerStats.health_empty.connect(_die)
	state_machine.init(self)
	Global.player = self
	
func _process(delta: float) -> void:
	state_machine.process(delta)

func _physics_process(delta: float) -> void:
	state_label.text = state_machine.current_state.name
	
	state_machine.physics_process(delta)
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.unhandled_input(event)


func _die():
	Sounds.play(Sounds.die)
	Utils.instantiate_scene_on_world(DIE_EFFECT_SCENE, global_position)
	set_physics_process(false)
	animation_player.play("die")
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://ui/die_menu.tscn")


func _on_hurtbox_hurt(damage) -> void:
	Events.add_screenshake.emit(2, 0.1)
	Events.player_hurt.emit()
	PlayerStats.health -= damage
	Sounds.play(Sounds.hurt)
	print_debug("hurt")
	override_animation_player.play("blink")
