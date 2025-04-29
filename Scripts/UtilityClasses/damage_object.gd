class_name DamageInstance

enum Types {GENERIC = 0, PHYSICAL, FIRE, WATER, LIGHT, ENTROPY}

var amount : float = 0.0
var type : Types = Types.GENERIC
var params : Dictionary = {}

func _init(d_amount : float = 0.0, d_type : Types = Types.GENERIC, d_params : Dictionary = {}) -> void:
	self.amount = d_amount
	self.type = d_type
	self.params = d_params
