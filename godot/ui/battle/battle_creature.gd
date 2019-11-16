extends Control
class_name BattleCreature

onready var sprite := $Sprite
onready var tween := $Tween

onready var health_bar := $HealthBar
onready var energy_bar := $EnergyBar

func set_sprite(texture: Texture, frames: int) -> void:
	sprite.texture = texture
	sprite.hframes = frames
	tween.reset_all()
	tween.stop_all()
	loop_animation()


func set_health(current: int, cap: int) -> void:
	health_bar.set_value_percentage(float(current) / float(cap))


func set_energy(current: int, cap: int) -> void:
	energy_bar.set_value_percentage(float(current) / float(cap))


func loop_animation() -> void:
	var time: float = sprite.hframes * 0.125
	tween.interpolate_property(sprite, "frame", 0, sprite.hframes - 1, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_callback(self, time, "loop_animation")
	tween.start()
