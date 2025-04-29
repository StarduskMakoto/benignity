class_name Event

enum EventTypes {EMPTY = -1, MOVEMENT = 0, DAMAGE}

var type : EventTypes = EventTypes.EMPTY
var max_handling : int = -1 # -1 = no limit
var params : Dictionary[String, Variant] = {}


func _parseFromJSON(json_string = "") -> void:
	pass

func _toJSON() -> String:
	var dict : Dictionary[String, Variant] = {
		"Type": type, "MaxHandling" : max_handling,
		"Params": params
	}
	
	
	var newString : String = JSON.stringify(dict)
	
	return newString
