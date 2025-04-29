class_name RoomNode
extends Node2D

enum roomIDs {
	U_END = 0, R_END, LUR_INT, LUD_INT, L_END, D_END,
	LU_TURN, LR_HALL, UD_HALL
}

static var TotalRooms : Array[RoomNode] = []

static func validate_rooms():
	var newRooms : Array[RoomNode] = []
	for r in TotalRooms:
		if not is_instance_valid(r):
			continue
		if not r.active:
			continue
		newRooms.append(r)
	TotalRooms = newRooms

@export var id : roomIDs = roomIDs.U_END
@export var active : bool = false
var markers : Array[LevelMarker] = []

func _init() -> void:
	TotalRooms.append(self)

func _ready() -> void:
	for child in get_children():
		if child is not LevelMarker:
			continue
		markers.append(child)

func get_marker(dir : LevelMarker.markerTypes) -> LevelMarker:
	for child in get_children():
		if child is not LevelMarker:
			continue
		if child.type != dir:
			continue
		return child
	return null

func get_marker_dirs() -> Array[LevelMarker.markerTypes]:
	var result : Array[LevelMarker.markerTypes] = []
	for child in get_children():
		if child is not LevelMarker:
			continue
		result.append(child.type)
	return result
