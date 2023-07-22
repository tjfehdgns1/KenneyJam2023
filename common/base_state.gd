extends Node
class_name BaseState
"""
State interface to use in Hierarchical State Machines.
"""

@export var animation_name : String


var player : Player


func enter() -> void:
	player.animation_player.play(animation_name)
	
func exit() -> void:
	pass
	
func unhandled_input(event: InputEvent) -> BaseState:
	return null

func process(delta: float) -> BaseState:
	return null

func physics_process(delta: float) -> BaseState:
	return null


