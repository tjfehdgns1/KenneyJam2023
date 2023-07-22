extends Area2D
class_name Hurtbox

signal hurt(damage)


func get_hit(damage):
	hurt.emit(damage)
