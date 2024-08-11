class_name Fall extends Move
##Subject Character to gravity.

func _init():
	var dur_override : float = 0.125
	base_duration = dur_override
	duration = base_duration
	vertical = true
