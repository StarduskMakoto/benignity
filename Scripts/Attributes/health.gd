extends Attribute

@export var maxHP : float = 100:
	set(value):
		maxHP = value
		if maxHP < 1:
			maxHP = 1
		update_health()

@export var currentHP : float = 100:
	set(value):
		currentHP = value
		if currentHP < 0:
			currentHP = 0
			active = false
		update_health()

@export var healthBar : TextureProgressBar

func _handle(ev : Event) -> bool:
	if ev.type not in self.eventHandles or not ev.params.has("Damage"):
		return true
	
	currentHP -= ev.params["Damage"]
	
	return true

func update_health():
	if not is_instance_valid(healthBar):
		return
	healthBar.max_value = maxHP
	healthBar.value = currentHP
