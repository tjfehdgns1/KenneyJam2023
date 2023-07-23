extends Node2D

@export var drawDelay := 0.01
@export var generateDelay := 0.001

#@export var userSeed := ""

@onready var rooms: Node2D = $Rooms

#const WIDTH = 1
const HEIGHT = 5

#const ROOM_WIDTH = 640
const ROOM_HEIGHT = 720

#var currentSeed : int = -1

var map := []
#var startPosition : int = 0

#enum EVENTS {DEFAULT, PITS}
#var event = EVENTS.DEFAULT


signal map_generated
signal map_drawn 

var room_option = ["0", "1", "2", "0", "0", "0"]
var room_option_left = []


func _ready() -> void:
#	currentSeed = GF.generateSeed(userSeed)
	
	generate_path()
	await self.map_generated
	
	print_map()
	await self.map_drawn
	
	
func generate_path() -> void:
	# S = start
	# 0 = straight
	# 1 = left
	# 2 = right
	# E = end
	
	map = []
	
	for room_index in HEIGHT:
		map.append("0")
	
	var pos_y := 0
	
	map[0] = "S"
	pos_y += 1
	
	while pos_y < HEIGHT-1:
		if room_option_left.is_empty():
			room_option_left = room_option.duplicate()
			room_option_left.shuffle()
		map[pos_y] = room_option_left.pop_front()
		pos_y += 1
	
	map[HEIGHT-1] = "E"
	print_debug("path generate")
	map_generated.emit()


func print_map():
	for room_index in HEIGHT:
		await get_tree().create_timer(drawDelay).timeout
		var path_name := ""
		
		match map[room_index]:
			"S":
				var start_room = random(1,3)
				path_name = str("res://level/start/start_", start_room ,".tscn")
				
			"0":
				var straight_room = random(1,3)
				path_name = str("res://level/straight/straight_", straight_room ,".tscn")
				
			"1":
				var left_room = random(1,1)
				path_name = str("res://level/left/left_", left_room ,".tscn")
				
			"2":
				var right_room = random(1,1)
				path_name = str("res://level/right/right_", right_room ,".tscn")
				
			"E":
				var end_room = random(1,3)
				path_name = str("res://level/end/end_", end_room ,".tscn")
				
		place_map(path_name, room_index * ROOM_HEIGHT)
		
	print_debug("map generate")
	map_drawn.emit()

	
func place_map(path, offsetY) -> void:
	var scene = load(path)
	var instance = scene.instantiate()
	rooms.add_child(instance)
	instance.position = Vector2(0, offsetY)

func random(minVal, maxVal):
	return randi() % maxVal + minVal
