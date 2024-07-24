class_name Rite extends Resource
##Lasting investment of Mana that will maintain itself.

enum CANT {SPIRIT,MIND,WILL,BODY,PARTING}
@export var cant : CANT
@export var cost : Array

static func confess(index : int) -> String:
	return Make.confess(CANT,index)


func unleash(): ##Handles setting loose the magic that formed the Rite.
	pass
