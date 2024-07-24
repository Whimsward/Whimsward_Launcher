class_name Aspect extends Node2D
##Synthesis of Paradigm and Elements, wreathes target entity.

enum Vantage {RELATION,INTENTION,CONTROL,BINDING,ISOLATION} 
@export var view : Vantage:
	set(value):
		view = value
		pgm = Vantage[Vantage.find_key(view)]
var pgm : Alignment.Paradigm

@export var components : Array[Mote]

func _ready():
	pass 


func upkeep(discount : int):
	var cost = 0
	for c : Mote in components:
		cost += c.weight
	cost = clampi(cost - discount,1,100)
	return cost


func factor_alignment(align : Alignment.Paradigm, score : int) -> int: ##Calculates if costs are reduced
	var factor = 0
	if align == pgm:
		factor = score
	return factor
