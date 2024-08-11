extends Game
##For now I'll use this to test displaying the contents of a Dictionary.

@export var arg : Argument

@onready var dict_in_a_box = $DictInABox

func _ready():
	Argument.compel_recitation(arg.gloss,dict_in_a_box)
