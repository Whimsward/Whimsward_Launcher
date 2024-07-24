class_name ManaMode extends Resource

enum Mode {PARADIGM,ASPECT,MEDIUM,ELEMENT,RITE,VIOLATION}
@export var mode : Mode

const COLORS : PackedColorArray = [Color.MAGENTA,Color.CYAN,Color.DARK_GREEN,Color.DARK_BLUE]

static func confess(index : int) -> String:
	return Mode.find_key(index).capitalize()
