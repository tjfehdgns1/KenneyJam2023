extends Node
class_name StateMachine


@export var initial_state : NodePath


var current_state: BaseState

func change_state(new_state : BaseState) -> void:
	if current_state:
		current_state.exit()
		
	current_state = new_state
	current_state.enter()


func init(player : Player) -> void:
	for child in get_children():
		child.player = player

	change_state(get_node(initial_state))

func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state:
		change_state(new_state)
		
func process(delta: float) -> void:
	var new_state = current_state.process(delta)
	if new_state:
		change_state(new_state)
		
func unhandled_input(event: InputEvent) -> void:
	var new_state = current_state.unhandled_input(event)
	if new_state:
		change_state(new_state)
