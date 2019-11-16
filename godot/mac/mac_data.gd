extends Resource
class_name MacData

export var name := ""
export var front_sprite: Texture = null
export var front_frames := 1
export var back_sprite: Texture = null
export var back_frames := 1
export(int, "Fighting", "Aerial") var combat_style = 0
export(int, "Pyro", "Aqua", "Terra") var type = 0
export var move_list := {} # 
export var stats := [] # Stats per level
export var xp_requirements := PoolIntArray([]) # XP per level
export var xp_drops := 0
