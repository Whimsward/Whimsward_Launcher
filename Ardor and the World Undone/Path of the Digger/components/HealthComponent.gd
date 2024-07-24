class_name HealthComponent extends Component
##Tracks HP values for the node that 'equips' it.

signal death_knell

@export var max_health : int = 1:
	set(value):
		max_health = clampi(value,1,9999)
@export var current_health : int = 1:
	set(value):
		current_health = clampi(value,0,max_health)
		if value <= 0:
			death_knell.emit()
@export var armor : int = 0:
	set(value):
		armor = clampi(value,0,3)

func take_damage(damage: int):
	armor = clampi(armor - damage,0,3)
	var rdmg = damage - armor
	current_health -= rdmg
	return current_health


func recover_health(healing: int):
	current_health += healing
	return current_health
