extends Node2D
class_name World



var player : Player

func _ready() -> void:
	Global.world = self
	RenderingServer.set_default_clear_color(Color8(118, 59, 54, 255))
	
