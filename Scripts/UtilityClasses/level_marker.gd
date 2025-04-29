class_name LevelMarker
extends Marker2D

enum markerTypes {LEFT = 0, UP, RIGHT, DOWN}

const markerOpposites : Dictionary[markerTypes, markerTypes] = {
	markerTypes.LEFT: markerTypes.RIGHT,
	markerTypes.UP: markerTypes.DOWN,
	markerTypes.RIGHT: markerTypes.LEFT,
	markerTypes.DOWN: markerTypes.UP
}

@export var type : markerTypes = markerTypes.LEFT
@export var connected : bool = false
