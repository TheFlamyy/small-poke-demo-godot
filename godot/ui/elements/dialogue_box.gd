extends NinePatchRect

signal text_displayed

onready var tween := $Tween
onready var label := $MarginContainer/Label

func display_text(text: String, duration: float) -> void:
	tween.stop_all()
	label.text = text
	tween.interpolate_property(label, "percent_visible", 0.0, 1.0, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_callback(self, duration, "emit_signal", "text_displayed")
	tween.start()


func show_all_text() -> void:
	tween.stop_all()
	label.percent_visible = 1.0
	emit_signal("text_displayed")
