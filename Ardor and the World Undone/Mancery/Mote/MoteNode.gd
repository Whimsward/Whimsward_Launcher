extends Node2D
##Experiments with loading Motes into a node object.

@export var type : Mote.Element:
	set(value):
		type = value
		if not value == 4:
			mote = load("res://mance/motes/"+Mote.confess(type)+".tres").duplicate()
		else: mote = load("res://mance/motes/Shadow.tres").duplicate()
		print_debug(mote.resource_name)

var mote : Mote
