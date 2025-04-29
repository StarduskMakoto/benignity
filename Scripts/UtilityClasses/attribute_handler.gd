class_name AttributeHandler
extends Node2D

func handle_event(event : Event):
	var count : int = 0
	
	for child in get_children():
		if child is not Attribute:
			continue
		if event.type not in child.eventHandles or not child.active:
			continue
		
		var result : bool = child._handle(event)
		
		if not result:
			break
		
		if event.max_handling < 0:
			continue
		count += 1
		if count >= event.max_handling:
			break
