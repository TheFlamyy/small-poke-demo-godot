extends TextureProgress
class_name ClampedProgressBar

export var minimum := 0
export var maximum := 0

func set_value_percentage(val: float) -> void:
	value = val * (maximum - minimum) + minimum
