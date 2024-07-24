class_name Mote extends Resource
##Used by Channels and other Node types to track material magic by species and amounts.

signal exhausted(mote : Mote)
signal updated(weight)

enum Element {FIRE,LIGHTNING,EARTH,WATER,VOID} ##Baseline Material, volatile if loosed.
@export var type : Element

@export var mote_name : String
@export var theme : Color

@export var mass : float = 1:
	set(value):
		mass = value
		weight = mass * unit
@export var unit : int = 1:
	set(value):
		unit = value
		weight = mass * unit
var weight : float


static func confess(index : int) -> String:
	return Make.confess(Element,index)


func get_weight():
	return weight


func has_type() -> String:
	return Mote.confess(type)


func coalesce(amt : int):
	unit += amt
	updated.emit(weight)


func spend(amt : int):
	unit = clampi(unit - amt,0,5)
	if unit == 0:
		exhausted.emit(self)
	else:
		updated.emit(weight)


func report_exhausted(port : Callable):
	exhausted.connect(port)


func report_updated(port : Callable):
	updated.connect(port)
