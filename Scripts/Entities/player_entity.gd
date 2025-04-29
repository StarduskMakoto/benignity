class_name Player
extends CharacterBody2D

var attrHandler : AttributeHandler = null

var SPEED : float = 50000.

func _ready() -> void:
	for child in get_children():
		if child is not AttributeHandler:
			continue
		attrHandler = child
		break

func _physics_process(delta: float) -> void:
	var d_y : float = Input.get_axis("ui_up", "ui_down")
	if d_y:
		velocity.y = d_y * SPEED * delta
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED * delta)
	
	var d_x : float = Input.get_axis("ui_left", "ui_right")
	if d_x:
		velocity.x = d_x * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
	
	move_and_slide()
