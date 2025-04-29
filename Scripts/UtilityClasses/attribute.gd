class_name Attribute
extends Node2D

@export var eventHandles : Array[Event.EventTypes] = []
@export var active : bool = true


func _handle(ev : Event) -> bool:
	return true
