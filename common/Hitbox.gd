extends Area2D
class_name Hitbox



@export var damage := 1





func _on_area_entered(hurtbox : Hurtbox) -> void:
	if not hurtbox is Hurtbox: return
	hurtbox.get_hit(damage) 
