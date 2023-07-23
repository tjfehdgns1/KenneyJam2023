extends Node


var player : Player = null
var world : World = null


var current_seed := -1

func random(min_value, max_value) -> int:
	return randi() % max_value + min_value
	
func random_bool(min_value, max_value, minRes, maxRes) -> bool:
	var rdm = randi() % max_value + min_value
	if rdm >= minRes and rdm <= maxRes:
		return true
	return false

func generate_seed(user_seed : String) -> int:
	if user_seed:
		current_seed = hash(user_seed)
	else:
		randomize()
		current_seed = randi()
		
	seed(current_seed)
	return current_seed
