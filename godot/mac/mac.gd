extends Node
class_name MAC

export(Resource) var mac_data = null
export var stats := {}
export var level := 0
export var xp := 0
export var health := 0
export var energy := 0

func _init(data: MacData, stats := {"max_health": 500, "max_energy": 100}, level := 1, xp := 0, health := 500, energy := 100) -> void:
	mac_data = data
	self.stats = stats
	self.level = level
	self.xp = xp
	self.health = health
	self.energy = energy
