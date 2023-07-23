extends Stats


signal max_resource_changed
signal resource_changed
signal resource_empty



@export var max_resource := 8 : set = set_max_resource
@onready var resource := 8 : set = set_resource


func set_max_resource(value):
	max_resource = value


func set_resource(value):
	resource = clamp(value, 0, max_resource)
	resource_changed.emit()
	
	if resource <= 0:
		resource_empty.emit()
