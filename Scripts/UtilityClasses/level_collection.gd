class_name LevelCollection
extends Node2D

class Room:
	var node : RoomNode = null
	var directions : Array[LevelMarker.markerTypes] = []
	
	func _init(n : RoomNode, dir : Array[LevelMarker.markerTypes]) -> void:
		node = n
		directions = dir

var rooms : Array[Room] = []

func _ready() -> void:
	for child in get_children():
		if child is not RoomNode:
			continue
		var newRoom = Room.new(child, child.get_marker_dirs())
		rooms.append(newRoom)

func get_matching_room(dir : LevelMarker.markerTypes) -> RoomNode:
	var needed_dir : LevelMarker.markerTypes = LevelMarker.markerOpposites[dir]
	var result_rooms : Array[RoomNode] = []
	for r in rooms:
		if needed_dir not in r.directions:
			continue
		result_rooms.append(r.node)
	
	if len(result_rooms) < 1:
		return null
	return result_rooms[randi_range(0, len(result_rooms) - 1)]

func get_room_by_id(id : RoomNode.roomIDs) -> RoomNode:
	for r in rooms:
		if r.node.id != id:
			continue
		return r.node
	return null
