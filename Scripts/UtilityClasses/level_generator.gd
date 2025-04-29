class_name LevelGenerator
extends Node2D

@export var depth : int = 3
@export var collection : LevelCollection

func _ready() -> void:
	var room = collection.get_room_by_id(RoomNode.roomIDs.D_END)
	var new_room = room.duplicate()
	self.add_child(new_room)
	new_room.position = Vector2.ZERO
	new_room.active = true
	RoomNode.validate_rooms()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		generate()

func generate() -> void:
	if not is_instance_valid(collection):
		return
	for d in range(depth):
		var roomsList = RoomNode.TotalRooms.duplicate()
		for r in roomsList:
			for m in r.markers:
				if m.connected:
					continue
				var room : RoomNode = collection.get_matching_room(m.type)
				if room == null:
					continue
				var new_room : RoomNode = room.duplicate()
				self.add_child(new_room)
				new_room.position = Vector2.ZERO
				new_room.active = true
				var r_marker : LevelMarker = new_room.get_marker(LevelMarker.markerOpposites[m.type])
				if r_marker != null:
					r_marker.connected = true
					var distance : Vector2 = m.global_position - r_marker.global_position
					new_room.position += distance
				RoomNode.validate_rooms()
	
